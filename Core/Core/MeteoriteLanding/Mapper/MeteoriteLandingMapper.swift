//
//  MeteoriteLandingMapper.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain

struct MeteoriteLandingMapper {
    static func map(from apiModel: [MeteoriteLandingApiModel]) -> [MeteoriteLanding] {
        return apiModel.map { apiModel in
            MeteoriteLanding(name: apiModel.name,
                             id: apiModel.id,
                             meteoriteClass: apiModel.recclass,
                             mass: Int(apiModel.mass),
                             fall: mapFall(apiModel.fall),
                             year: apiModel.year,
                             location: mapLocation(apiModel.geolocation))
        }
    }
    
    private static func mapFall(_ fallType: String) -> FallingState? {
        switch fallType {
        case "Found":
            return .found
        case "Fell":
            return .fell
        default:
            return nil
        }
    }
    
    private static func mapLocation(_ apiModel: GeoLocationApiModel) -> GeoLocation {
        return GeoLocation(longitude: apiModel.coordinates[0], latitude: apiModel.coordinates[1])
    }
}
