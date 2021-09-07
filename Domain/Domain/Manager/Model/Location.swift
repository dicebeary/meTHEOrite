//
//  Location.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import Foundation

public struct Location {
    public let longitude: Double
    public let latitude: Double
    
    public init(longitude: Double,
                latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
