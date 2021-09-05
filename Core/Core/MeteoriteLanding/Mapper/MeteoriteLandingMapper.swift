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
                             mass: Double(apiModel.mass ?? ""),
                             fall: mapFall(apiModel.fall),
                             year: mapDate(apiModel.year),
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
    
    private static func mapLocation(_ apiModel: GeoLocationApiModel?) -> GeoLocation? {
        guard let apiModel = apiModel else { return nil }
        return GeoLocation(longitude: apiModel.coordinates[0], latitude: apiModel.coordinates[1])
    }
    
    private static func mapDate(_ year: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: year)
        return date ?? Date(timeIntervalSince1970: 0)
    }
}
