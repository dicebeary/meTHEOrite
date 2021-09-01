//
//  NewsArticleApiModel.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

struct NewsArticleApiModel: Codable {
    var source: NewsSourceApiModel
    var title: String
    var author: String?
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}
