//
//  Source.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Foundation

public struct Source {
    public var id: String
    public var language: String
    public var country: String
    public var category: String

    public init(id: String,
                language: String,
                country: String,
                category: String) {
        self.id = id
        self.language = language
        self.country = country
        self.category = category
    }
}
