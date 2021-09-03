//
//  GeoLocationApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

struct GeoLocationApiModel: Codable {
    let type: String
    let coordinates: [Double]
}
