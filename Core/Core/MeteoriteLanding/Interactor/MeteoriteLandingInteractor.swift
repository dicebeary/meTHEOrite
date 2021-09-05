//
//  MeteoriteLandingInteractor.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain
import RxSwift
import RxCocoa
import RxOptional
import Resolver

final class MeteoriteLandingInteractor: MeteoriteLandingInteractorInterface {
    
    @Injected private var meteoriteLandingService: MeteoriteLandingServiceInterface
    @Injected private var cache: VerySimpleCache

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
        landings
            .take(1)
            .asSingle()
            .do(onSuccess: { [weak self] landings in
                let sortedLandings = landings.sorted { [weak self] landing1, landing2 in
                    return self?.sort(lhs: landing1, rhs: landing2, by: attribute) ?? false
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
            var favourites = self?.favouritesSubject.value
            favourites = favourites?.filter { $0 != id }
            self?.cache.save(object: favourites, forKey: CoreConstants.favouritesKey)
            self?.favouritesSubject.accept(favourites)

            completable(.completed)
            return Disposables.create()
        }
    }
    
    private func sort(lhs: MeteoriteLanding, rhs: MeteoriteLanding, by type: MeteoriteAttribute) -> Bool {
        switch type {
        case .location:
            // TODO
        return false
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
