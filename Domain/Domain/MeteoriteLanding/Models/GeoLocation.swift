//
//  GeoLocation.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

public struct GeoLocation {
    public let longitude: Double
    public let latitude: Double
    
    public init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
