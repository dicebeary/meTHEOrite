//
//  SourcesApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Foundation

struct SourcesApiModel: Codable {
    var status: NewsStatusApiEnum
    var sources: [SourceItemApiModel]
}
