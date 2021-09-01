//
//  NewsService.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation
import RxSwift
import Moya
import Resolver

class NewsService: NewsServiceInterface {

    @Injected private var provider: MoyaProvider<NewsApi>

    func getNewsList(text: String?) -> Single<NewsApiModel> {
        return provider.rx.request(.topHeadlines(text: text))
            .filterSuccessfulStatusCodes()
            .parseError()
            .map(NewsApiModel.self)
    }

    func getSources() -> Single<SourcesApiModel> {
        return provider.rx.request(.sources)
            .filterSuccessfulStatusCodes()
            .parseError()
            .map(SourcesApiModel.self)
    }
}
