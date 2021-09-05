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
        let screenEvents: ListViewController.Events
    }

    struct Output {
        let screenData: ListViewController.Data
    }

    func map(from input: Input) -> Output {
        // Listening events
        updateFavourite(by: input.screenEvents.favouriteSelected)

        // Gathering data
        let screenData = ListViewController.Data(items: getItems())

        return Output(screenData: screenData)
    }
}

// MARK: - Event handling
private extension ListViewModel {
    func updateFavourite(by events: ControlEvent<FavouriteToggle>) {
        events.asObservable()
            .flatMapLatest { [interactor] (id: String, selected: Bool) -> Completable in
                if selected {
                    return interactor.removeFavourite(id: id)
                } else {
                    return interactor.saveFavourite(id: id)
                }
        }
        .subscribe()
        .disposed(by: bag)
    }
}

// MARK: - Output helper methods
private extension ListViewModel {
    func getItems() -> Driver<[MeteoriteCell.Data]> {
        Observable.combineLatest(interactor.landings, interactor.favourites)
            .map { landings, favourites in
                landings.map { landing in
                    let isFavourite = favourites.contains(landing.id)
                    return MeteoriteCell.Data(id: landing.id,
                                              title: landing.name,
                                              isFavourite: isFavourite)
                }
            }
            .asDriver(onErrorJustReturn: [])
    }
}
