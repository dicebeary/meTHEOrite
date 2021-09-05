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

    
    func fetchLandings() -> Completable {
        return meteoriteLandingService.getMeteoriteLandings()
            .cacheResponse(to: cache, as: CoreConstants.landingsKey)
            .restoreResponseIfError(from: cache, as: CoreConstants.landingsKey)
            .map(MeteoriteLandingMapper.map)
            .flatMapCompletable { [weak landingsSubject] landings in
                landingsSubject?.accept(landings)
                return .complete()
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
}
