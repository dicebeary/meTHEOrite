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
    @Injected private var landingInteractor: MeteoriteLandingInteractorInterface
    @Injected private var userInteractor: UserInteractorInterface
    
    private let bag = DisposeBag()
}

// MARK: - Transform data flow
extension MapViewModel: ViewModelMappable {
    struct Input {}

    struct Output {
        let userLocation: Driver<Location>
        let pins: Driver<[MeteoriteAnnotation]>
    }

    func map(from input: Input) -> Output {
        let annotations = getAnnotations()
        let userLocation = userInteractor.userLocation
            .observeOn(MainScheduler.asyncInstance)
            .filterNil()
            .asDriver(onErrorDriveWith: .empty())
        return Output(userLocation: userLocation,
                      pins: annotations)
    }
}

// MARK: - Event handling
private extension MapViewModel {
}

// MARK: - Output helper methods
private extension MapViewModel {
    func getAnnotations() -> Driver<[MeteoriteAnnotation]> {
        return landingInteractor.landings
            .map { landings in
                landings.compactMap { landing in
                    guard let location = landing.location else { return nil }
                    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                    return MeteoriteAnnotation(title: landing.name, coordinate: coordinate)
                }
            }.asDriver(onErrorJustReturn: [])
    }
}
