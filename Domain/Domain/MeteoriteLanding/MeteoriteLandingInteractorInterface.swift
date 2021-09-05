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
    var favourites: Observable<[String]> { get }
    
    func fetchLandings() -> Completable
    func fetchFavourites() -> Completable

    func saveFavourite(id: String) -> Completable
    func removeFavourite(id: String) -> Completable
}
