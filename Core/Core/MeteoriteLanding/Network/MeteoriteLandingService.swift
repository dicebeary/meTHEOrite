//
//  MeteoriteLandingService.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Moya
import RxSwift
import Resolver

final class MeteoriteLandingService: MeteoriteLandingServiceInterface {
    
    @Injected private var provider: MoyaProvider<MeteoriteLandingAPI>
    
    func getMeteoriteLandings() -> Single<[MeteoriteLandingApiModel]> {
        return provider.rx.request(.getLandings)
            .filterSuccessfulStatusCodes()
            .map([MeteoriteLandingApiModel].self)
    }
}
