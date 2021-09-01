//
//  NewsInteractor.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Domain
import RxSwift
import RxCocoa
import Resolver

class NewsInteractor {
    // Relays for local storing
    private let selectedArticleRelay = BehaviorRelay<Article?>(value: nil)
    private let sourcesRelay = BehaviorRelay<[Source]?>(value: nil)
    private let newsRelay = PublishRelay<[Article]>()

    // Dependencies
    @Injected private var service: NewsServiceInterface
}

// MARK: - NewsInteractorInterface conformation
extension NewsInteractor: NewsInteractorInterface {
    func getNews() -> Observable<[Article]> {
        newsRelay.asObservable()
    }

    func getSelectedArticle() -> Observable<Article> {
        selectedArticleRelay.asObservable()
            .filter { $0 != nil }
            .map { $0! }
    }

    func fetchNews(text: String?) -> Completable {
        let currentSources = sourcesRelay
            .filter { $0 != nil }
            .map { $0! }
            .take(1)
            .asSingle()

        return Single.zip(service.getNewsList(text: text), currentSources)
            .map { return ($0.0.articles, $0.1) }
            .map { articles, sources in
                return try articles.map { article in
                    try NewsInteractor.map(from: article, with: sources)
                }
            }
            .do(onSuccess: { [weak self] news in
                self?.newsRelay.accept(news)
            })
            .asCompletable()
    }

    func fetchSources() -> Completable {
        return service.getSources()
            .map(\.sources)
            .map { $0.map { NewsInteractor.map(from: $0) } }
            .do(onSuccess: { [weak self] sources in
                self?.sourcesRelay.accept(sources)
            })
            .asCompletable()
    }

    func selectArticle(_ item: Article) -> Completable {
        return Completable.create { [weak self] completable -> Disposable in
            self?.selectedArticleRelay.accept(item)
            completable(.completed)
            return Disposables.create()
        }
    }
}


// MARK: - Mappers
private extension NewsInteractor {
    static func map(from sourceApiModel: SourceItemApiModel) -> Source {
        return Source(id: sourceApiModel.id,
                      language: sourceApiModel.language,
                      country: sourceApiModel.country,
                      category: sourceApiModel.category)
    }

    static func map(from articleApiModel: NewsArticleApiModel, with sources: [Source]) throws -> Article {
        guard let url = URL(string: articleApiModel.url) else { throw NewsError.parseError(propertyName: "url") }
        let imageUrl = URL(string: articleApiModel.urlToImage ?? "")
        let category = mapCategory(of: articleApiModel.source.id, from: sources)
        let language = mapLanguage(of: articleApiModel.source.id, from: sources)
        let publishedDate = map(articleApiModel.publishedAt)

        return Article(title: articleApiModel.title,
                       articleURL: url,
                       imageURL: imageUrl,
                       content: articleApiModel.content ?? "",
                       category: category,
                       language: language,
                       publishedDate: publishedDate ?? Date())
    }

    static func mapCategory(of sourceId: String?, from sources: [Source]) -> String? {
        guard let id = sourceId else { return nil }
        let source = sources.first(where: { $0.id == id })
        return source?.category
    }

    static func mapLanguage(of sourceId: String?, from sources: [Source]) -> String? {
        guard let id = sourceId else { return nil }
        let source = sources.first(where: { $0.id == id })
        return source?.language
    }

    static func map(_ iso8601String: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return dateFormatter.date(from: iso8601String)
    }
}
