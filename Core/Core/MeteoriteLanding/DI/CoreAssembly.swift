//
//  CoreAssembly.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

//import Swinject
import Domain
import Moya
import Resolver

public extension Resolver {
    static func assembleCore() {
        register { MeteoriteLandingInteractor() }
            .implements(MeteoriteLandingInteractorInterface.self)
            .scope(.application)
        register { MeteoriteLandingService() }
            .implements(MeteoriteLandingServiceInterface.self)
        register { _ -> MoyaProvider<MeteoriteLandingAPI> in
            switch AppInfo.environment {
            case .mock:
                let stubClosure: MoyaProvider<MeteoriteLandingAPI>.StubClosure = { _ in return StubBehavior.delayed(seconds: 1.0) }
                return MoyaProvider<MeteoriteLandingAPI>(stubClosure: stubClosure,
                                             plugins: [NetworkLoggerPlugin()])
            case .prod:
                return MoyaProvider<MeteoriteLandingAPI>(plugins: [NetworkLoggerPlugin()])
            }
        }
        .scope(.application)

        register { VerySimpleCache() }
            .implements(Cacheable.self)
    }
}
