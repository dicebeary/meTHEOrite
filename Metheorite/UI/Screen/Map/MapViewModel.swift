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
import CoreLocation

final class MapViewModel {
    @Injected private var interactor: MeteoriteLandingInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension MapViewModel: ViewModelMappable {
    struct Input {}

    struct Output {
        let pins: Driver<[MeteoriteAnnotation]>
    }

    func map(from input: Input) -> Output {
        let annotations = getAnnotations()
        return Output(pins: annotations)
    }
}

// MARK: - Event handling
private extension MapViewModel {
}

// MARK: - Output helper methods
private extension MapViewModel {
    func getAnnotations() -> Driver<[MeteoriteAnnotation]> {
        return interactor.landings
            .map { landings in
                landings.compactMap { landing in
                    guard let location = landing.location else { return nil }
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                    return MeteoriteAnnotation(title: landing.name, coordinate: coordinate)
                }
            }.asDriver(onErrorJustReturn: [])
    }
}
