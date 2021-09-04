//
//  ListViewModel.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

final class ListViewModel {
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension ListViewModel: ViewModelMappable {
    struct Input {
//        let screenEvents: ListViewController.Events
    }

    struct Output {
        let screenData: ListViewController.Data
    }

    func map(from input: Input) -> Output {
        // Listening events
        fetchInitialData()

        // Gathering data
        let screenData = ListViewController.Data(items: getItems())

        return Output(screenData: screenData)
    }
}

// MARK: - Event handling
private extension ListViewModel {
    func fetchInitialData() {
        interactor.getLandings()
            .subscribe()
            .disposed(by: bag)
    }
}

// MARK: - Output helper methods
private extension ListViewModel {
    func getItems() -> Driver<[MeteoriteCell.Data]> {
        interactor.landings
            .map { landings in
                landings.map { landing in
                    return MeteoriteCell.Data(title: landing.name)
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
