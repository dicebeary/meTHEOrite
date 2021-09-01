//
//  NewsServiceInterface.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import RxSwift

// sourcery: AutoMockable
protocol NewsServiceInterface {

    /**
     Fetch *\/top-headlines* endpoint
        - Parameter text: Represents **q** query parameter
     */
    func getNewsList(text: String?) -> Single<NewsApiModel>

    /// Fetch */top-headlines/sources* endpoint
    func getSources() -> Single<SourcesApiModel>
}
