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

    var landings: Observable<[MeteoriteLanding]> {
        return landingsSubject
            .filterNil()
    }
    
    func getLandings() -> Completable {
        return meteoriteLandingService.getMeteoriteLandings()
            .cacheResponse(to: cache, as: CoreConstants.cacheKey)
            .restoreResponseIfError(from: cache, as: CoreConstants.cacheKey)
            .map(MeteoriteLandingMapper.map)
            .flatMapCompletable { [weak landingsSubject] landings in
                landingsSubject?.accept(landings)
                return .complete()
            }
    }
}
