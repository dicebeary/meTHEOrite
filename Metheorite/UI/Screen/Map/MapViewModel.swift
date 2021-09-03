//
//  MapViewModel.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

final class MapViewModel {
    @Injected private var newsInteractor: NewsInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension MapViewModel: ViewModelManipulator {
    func navigate(from viewController: UIViewController) {}

    struct Input {}

    struct Output {
        let screenData: MapViewController.Data
    }

    func map(from input: Input) -> Output {
        let screenData = getScreenData()
        return Output(screenData: screenData)
    }
}

// MARK: - Event handling
private extension MapViewModel {
}

// MARK: - Output helper methods
private extension MapViewModel {
    func getScreenData() -> MapViewController.Data {
        let imageUrl = newsInteractor.getSelectedArticle()
            .map(\.imageURL)
            .asDriver(onErrorJustReturn: nil)
        
        let category = newsInteractor.getSelectedArticle()
            .map(\.category)
            .map { $0?.uppercased() }
            .asDriver(onErrorJustReturn: nil)

        let language = newsInteractor.getSelectedArticle()
            .map(\.language)
            .map { $0?.uppercased() }
            .asDriver(onErrorJustReturn: nil)

        let title = newsInteractor.getSelectedArticle()
            .map(\.title)
            .asDriver(onErrorJustReturn: "")

        let content = newsInteractor.getSelectedArticle()
            .map(\.content)
            .asDriver(onErrorJustReturn: "")
        return MapViewController.Data(imageUrl: imageUrl, language: language, category: category, title: title, content: content)
    }
}
