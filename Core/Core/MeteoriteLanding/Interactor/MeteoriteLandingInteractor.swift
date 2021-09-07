//
//  MeteoriteLandingInteractor.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import CoreLocation
import Domain
import RxSwift
import RxCocoa
import RxOptional
import Resolver

final class MeteoriteLandingInteractor: MeteoriteLandingInteractorInterface {
    
    @Injected private var meteoriteLandingService: MeteoriteLandingServiceInterface
    @Injected private var locationManager: LocationManaging
    @Injected private var cache: Cacheable

    private var landingsSubject = BehaviorRelay<[MeteoriteLanding]?>(value: nil)
    private var favouritesSubject = BehaviorRelay<[String]?>(value: nil)
    
    var landings: Observable<[MeteoriteLanding]> {
        return landingsSubject
            .filterNil()
    }

    var favourites: Observable<[String]> {
        return favouritesSubject
            .filterNil()
    }
    
    var sortingTypes: Observable<[MeteoriteAttribute]> {
         .just(MeteoriteAttribute.allCases)
    }
    
    func fetchLandings() -> Completable {
        return meteoriteLandingService.getMeteoriteLandings()
            .cacheResponse(to: cache, as: CoreConstants.landingsKey)
            .restoreResponseIfError(from: cache, as: CoreConstants.landingsKey)
            .map(MeteoriteLandingMapper.map)
            .flatMapCompletable { [weak landingsSubject] landings in
                landingsSubject?.accept(landings)
                return .empty()
            }
    }

    func fetchFavourites() -> Completable {
        return Completable.create { [weak self] completable in
            debugPrint("Fetch favourites")
            let favourites = self?.cache.load(type: [String].self, forKey: CoreConstants.favouritesKey) ?? []
            self?.favouritesSubject.accept(favourites)

            completable(.completed)
            return Disposables.create()
        }
    }
    
    func sortMeteorite(by attribute: MeteoriteAttribute) -> Completable {
        Observable.zip(locationManager.userLocation.filterNil(), landings)
            .take(1)
            .asSingle()
            .do(onSuccess: { [weak self] userLocation, landings in
                let sortedLandings = landings.sorted { [weak self] landing1, landing2 in
                    return self?.sort(lhs: landing1, rhs: landing2, by: attribute, with: userLocation) ?? false
                }
                self?.landingsSubject.accept(sortedLandings)
            })
            .asCompletable()
    }

    func saveFavourite(id: String) -> Completable {
        return Completable.create { [weak self] completable in
            var favourites = self?.favouritesSubject.value
            favourites?.append(id)
            self?.cache.save(object: favourites, forKey: CoreConstants.favouritesKey)
            self?.favouritesSubject.accept(favourites)

            completable(.completed)
            return Disposables.create()
        }
    }
    
    func removeFavourite(id: String) -> Completable {
        return Completable.create { [weak self] completable in
            let oldFavourites = self?.favouritesSubject.value
            let newFavourites = oldFavourites?.filter { $0 != id }
            self?.cache.save(object: newFavourites, forKey: CoreConstants.favouritesKey)
            self?.favouritesSubject.accept(newFavourites)

            completable(.completed)
            return Disposables.create()
        }
    }
    
    private func sort(lhs: MeteoriteLanding,
                      rhs: MeteoriteLanding,
                      by type: MeteoriteAttribute,
                      with location: CLLocation) -> Bool {
        switch type {
        case .location:
            guard let lLocation = lhs.location, let rLocation = rhs.location else {
                return false
            }
            let lhsLocation = CLLocation(latitude: lLocation.latitude, longitude: lLocation.longitude)
            let rhsLocation = CLLocation(latitude: rLocation.latitude, longitude: rLocation.longitude)

            let userLhsLocationDistance = location.distance(from: lhsLocation)
            let userRhsLocationDistance = location.distance(from: rhsLocation)
            return userLhsLocationDistance < userRhsLocationDistance
        case .name:
            return lhs.name < rhs.name
        case .mass:
            return lhs.mass ?? 0.0 < rhs.mass ?? 0.0
        case .class:
            return lhs.meteoriteClass < rhs.meteoriteClass
        case .date:
            return lhs.year < rhs.year
        }
    }
}
