//
//  ListViewMapper.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import Domain

struct ListViewMapper {
    static func map(from article: Article, index: Int) -> NewsCell.Data {
        return NewsCell.Data(title: article.title,
                             elapsedTime: article.publishedDate.timeAgoSinceDate(),
                             image: article.imageURL,
                             isFirst: index == 0)
    }
}
