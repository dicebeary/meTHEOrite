//
//  Article.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

public struct Article: Equatable {
    public var title: String
    public var articleURL: URL
    public var imageURL: URL?
    public var content: String
    public var category: String?
    public var language: String?
    public var publishedDate: Date

    public init(title: String,
                articleURL: URL,
                imageURL: URL?,
                content: String,
                category: String?,
                language: String?,
                publishedDate: Date) {
        self.title = title
        self.articleURL = articleURL
        self.imageURL = imageURL
        self.content = content
        self.category = category
        self.language = language
        self.publishedDate = publishedDate
    }
}
