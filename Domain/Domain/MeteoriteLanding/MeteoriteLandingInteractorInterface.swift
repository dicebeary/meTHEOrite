//
//  MeteoriteLandingInteractorInterface.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import RxSwift

// sourcery: AutoMockable
public protocol MeteoriteLandingInteractorInterface {
    /// Meteorite landings from NASA endpoint
    var landings: Observable<[MeteoriteLanding]> { get }
    /// Locally stored favourite landings
    var favourites: Observable<[String]> { get }
    /// Like the name of the variable says; it stores the type of possible sortings
    var sortingTypes: Observable<[MeteoriteAttribute]> { get }
    
    /// Fetch network data of meteorite landings
    func fetchLandings() -> Completable
    /// Fetch favourites from local storage
    func fetchFavourites() -> Completable
    
    /// Sort `landings` data by given attribute
    func sortMeteorite(by attribute: MeteoriteAttribute) -> Completable

    /// Save favourite meteorite landing by its id
    func saveFavourite(id: String) -> Completable
    /// Remove favourite meteorite landing by its id
    func removeFavourite(id: String) -> Completable
}
