//
//  SortPopoverViewModel.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

final class SortPopoverViewModel {
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension SortPopoverViewModel: ViewModelMappable {
    struct Input {}

    struct Output {
        let items: Driver<[String]>
    }

    func map(from input: Input) -> Output {
        return Output(items: getItems())
    }
}

// MARK: - Output data getters
private extension SortPopoverViewModel {
    func getItems() -> Driver<[String]> {
        return interactor.sortingTypes
            .map { $0.map(\.localizedAttribute) }
            .asDriver(onErrorJustReturn: [])
    }
}
