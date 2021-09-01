//
//  NewsErrorApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

struct NewsErrorApiModel: Codable {
    var status: NewsStatusApiEnum
    var code: String
    var message: String
}
