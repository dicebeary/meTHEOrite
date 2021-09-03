//
//  ListViewModel.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

final class ListViewModel {
    @Injected private var newsInteractor: NewsInteractorInterface
    @Injected private var navigator: NavigatorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension ListViewModel: ViewModelManipulator {
    struct Input {
        let screenEvents: ListViewController.Events
    }

    struct Output {
        let screenData: ListViewController.Data
    }

    func map(from input: Input) -> Output {
        // Listening events
        fetchInitialData()
        searchNews(from: input.screenEvents.searchTextChanged)
        selectItem(from: input.screenEvents.itemSelected)

        // Gathering data
        let screenData = ListViewController.Data(items: getItems())

        return Output(screenData: screenData)
    }

//    func navigate(from viewController: UIViewController) {
//        newsInteractor.getSelectedArticle()
//            .subscribe { [weak self] _ in
//                self?.navigator.push(from: viewController, to: UIConstants.StoryboardIdentifier.details)
//            }.disposed(by: bag)
//    }
}

// MARK: - Event handling
private extension ListViewModel {
    func fetchInitialData() {
        newsInteractor.fetchNews(text: nil)
            .subscribe()
            .disposed(by: bag)

        newsInteractor.fetchSources()
            .subscribe()
            .disposed(by: bag)
    }

    func searchNews(from searchTextEvents: ControlEvent<String?>) {
        searchTextEvents
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [newsInteractor, bag] text in
                newsInteractor.fetchNews(text: text)
                    .subscribe()
                    .disposed(by: bag)
            }.disposed(by: bag)
    }

    func selectItem(from tableViewEvents: ControlEvent<IndexPath>) {
        tableViewEvents
            .asObservable()
            .withLatestFrom(newsInteractor.getNews()) { ($0, $1) }
            .subscribe(onNext: { [newsInteractor, bag] indexPath, articles in
                let article = articles[indexPath.row]
                newsInteractor.selectArticle(article)
                    .subscribe()
                    .disposed(by: bag)
            }).disposed(by: bag)
    }
}

// MARK: - Output helper methods
private extension ListViewModel {
    func getItems() -> Driver<[NewsCell.Data]> {
        newsInteractor.getNews()
            .map { $0.enumerated().map { ListViewMapper.map(from: $0.element, index: $0.offset) } }
            .asDriver(onErrorJustReturn: [])
    }
}
