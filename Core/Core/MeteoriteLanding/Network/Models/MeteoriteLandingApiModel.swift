//
//  MeteoriteLandingApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

struct MeteoriteLandingApiModel: Codable {
    let name: String
    let id: String
    let nametype: String
    let recclass: String
    let mass: String
    let fall: String
    let year: String
    let reclat: String
    let reclong: String
    let geolocation: GeoLocationApiModel
}
