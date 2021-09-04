//
//  MeteoriteLandingInteractorInterface.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import RxSwift

// sourcery: AutoMockable
public protocol MeteoriteLandingInteractorInterface {
    var landings: Observable<[MeteoriteLanding]> { get }
    
    func getLandings() -> Completable
}
