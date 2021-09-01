//
//  NewsInteractorInterface.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import RxSwift

// sourcery: AutoMockable
public protocol NewsInteractorInterface {

    /// News getter for top-headlines data
    func getNews() -> Observable<[Article]>

    /// Reactive property for selected article on list
    func getSelectedArticle() -> Observable<Article>

    /**
     Trigger method for fetching top headlines
        - Parameter text: String for searching given text between articles
     */
    func fetchNews(text: String?) -> Completable

    /// Trigger method for fetching sources for articles to gather category and country
    func fetchSources() -> Completable

    /**
     Select an article object for showing on details
        - Parameter item: Particular item which has been selected
     */
    func selectArticle(_ item: Article) -> Completable
}
