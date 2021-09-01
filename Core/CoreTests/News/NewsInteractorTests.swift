//
//  NewsInteractorTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import XCTest
import Nimble
import RxBlocking
import SwiftyMocky
@testable import Core
@testable import Domain

class NewsInteractorTests: XCTestCase {
    var service: NewsServiceInterfaceMock!
    var sut: NewsInteractorInterface!

    override func setUp() {
        super.setUp()

        service = NewsServiceInterfaceMock()
        sut = NewsInteractor(service: service)
    }

    override func tearDown() {
        service = nil
        sut = nil
        super.tearDown()
    }

    func testSuccessfulFetchNews() throws {
        // Arrange
        let givenQueryText = "queryText"
        Given(service, .getNewsList(text: .any, willReturn: .just(mockNews)))
        Given(service, .getSources(willReturn: .just(mockSourcesEmpty)))

        // Act
        sut.fetchSources()
            .subscribe()
            .dispose()

        sut.fetchNews(text: givenQueryText)
            .subscribe()
            .dispose()

        // Assert
        Verify(service, 1, .getNewsList(text: .value(givenQueryText)))
        Verify(service, 1, .getSources())
    }

    func testFetchNewsWithUnfetchedSources() throws {
        // Arrange
        Given(service, .getNewsList(text: .any, willReturn: .just(mockNews)))
        Given(service, .getSources(willReturn: .never()))

        // Act
        guard (try? sut.getNews().toBlocking(timeout: 1.0).first()) == nil else {
            fail("News got emitted unexpectedly")
            return
        }

        sut.fetchNews(text: nil)
            .subscribe()
            .dispose()

        // Assert
        Verify(service, 1, .getNewsList(text: .any))
    }

    func testSelectArticle() throws {
        // Arrange

        // Act
        sut.selectArticle(mockDomainArticle)
            .subscribe()
            .dispose()

        // Assert
        let article = try sut.getSelectedArticle().toBlocking(timeout: 1.0).first()
        expect(article?.title).to(equal(mockDomainArticle.title))
        expect(article?.articleURL).to(equal(mockDomainArticle.articleURL))
    }
}

// MARK: - Mock data
private extension NewsInteractorTests {
    var mockNews: NewsApiModel {
        return NewsApiModel(status: .ok, totalResults: 100, articles: [mockArticle1, mockArticle2, mockArticle3])
    }

    var mockArticle1: NewsArticleApiModel {
        return NewsArticleApiModel(source: NewsSourceApiModel(id: "1234", name: "asd"),
                                   title: "title1",
                                   author: "author1",
                                   description: "Description1",
                                   url: "https://example.com",
                                   urlToImage: "http://exmple.com/image.png",
                                   publishedAt: "2021-02-22T10:55:10Z",
                                   content: "content1")
    }

    var mockArticle2: NewsArticleApiModel {
        return NewsArticleApiModel(source: NewsSourceApiModel(id: "4567", name: "dsa"),
                                   title: "title2",
                                   author: "author2",
                                   description: "Description2",
                                   url: "https://example.com",
                                   urlToImage: "http://exmple.com/image2.png",
                                   publishedAt: "2020-11-13T10:55:10Z",
                                   content: "content2")
    }

    var mockArticle3: NewsArticleApiModel {
        return NewsArticleApiModel(source: NewsSourceApiModel(id: "6789", name: "qwertz"),
                                   title: "title2",
                                   author: "author2",
                                   description: "description2",
                                   url: "https://example.com",
                                   urlToImage: "http://exmple.com/image3.png",
                                   publishedAt: "2021-12-24T10:55:10Z",
                                   content: "content3")
    }

    var mockSourcesEmpty: SourcesApiModel {
        return SourcesApiModel(status: .ok, sources: [])
    }

    var mockDomainArticle: Article {
        return Article(title: "Article",
                       articleURL: URL(string: "https://example.com")!,
                       imageURL: URL(string: "https://example.com/imageURL.png"),
                       content: "Content",
                       category: "Category",
                       language: "Language",
                       publishedDate: Date())
    }
}
