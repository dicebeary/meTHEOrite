//
//  NewsApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

struct NewsApiModel: Codable {
    var status: NewsStatusApiEnum
    var totalResults: Int
    var articles: [NewsArticleApiModel]
}
