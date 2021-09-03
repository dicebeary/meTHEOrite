//
//  MeteoriteLandingServiceInterface.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import RxSwift

protocol MeteoriteLandingServiceInterface {
    func getMeteoriteLandings() -> Single<[MeteoriteLandingApiModel]>
}
