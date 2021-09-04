//
//  MapViewModel.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

final class MapViewModel {
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension MapViewModel: ViewModelMappable {
    struct Input {}

    struct Output {
//        let screenData: MapViewController.Data
    }

    func map(from input: Input) -> Output {
//        let screenData = getScreenData()
        return Output()
    }
}

// MARK: - Event handling
private extension MapViewModel {
}

// MARK: - Output helper methods
private extension MapViewModel {
}
