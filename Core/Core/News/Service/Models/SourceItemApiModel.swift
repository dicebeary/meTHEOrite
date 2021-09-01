//
//  SourceItemApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Foundation

struct SourceItemApiModel: Codable {
    var id: String
    var name: String
    var description: String
    var url: String
    var category: String
    var language: String
    var country: String
}
