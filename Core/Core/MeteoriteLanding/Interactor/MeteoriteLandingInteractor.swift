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
    
    private var landingsSubject = BehaviorRelay<[MeteoriteLanding]?>(value: nil)
    @Injected private var meteoriteLandingService: MeteoriteLandingServiceInterface

    var landings: Observable<[MeteoriteLanding]> {
        return landingsSubject
            .filterNil()
    }
    
    func getLandings() -> Completable {
        return meteoriteLandingService.getMeteoriteLandings()
            .map(MeteoriteLandingMapper.map)
            .do(onSuccess: { [weak landingsSubject] landings in
                landingsSubject?.accept(landings)
            })
            .asCompletable()
    }
}
