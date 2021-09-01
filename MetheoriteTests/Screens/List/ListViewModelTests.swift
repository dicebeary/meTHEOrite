//
//  ListViewModelTests.swift
//  FortnightlyTests
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import XCTest
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import SwiftyMocky
@testable import Core
@testable import Domain
@testable import Fortnightly

class ListViewModelTests: XCTestCase {
    var interactor: NewsInteractorInterfaceMock!
    var navigator: NavigatorInterfaceMock!
    var sut: ListViewModel!

    let completable = Completable.create { completable -> Disposable in
        completable(.completed)
        return Disposables.create()
    }


    override func setUp() {
        super.setUp()

        interactor = NewsInteractorInterfaceMock()
        navigator = NavigatorInterfaceMock()
        sut = ListViewModel(newsInteractor: interactor, navigator: navigator)
    }

    override func tearDown() {
        interactor = nil
        navigator = nil
        sut = nil
        super.tearDown()
    }

    func testEmptyScreenData() {
        // Arrange
        let givenEmptySelection = ControlEvent<IndexPath>(events: Observable<IndexPath>.empty())
        let givenEmptySearch = ControlEvent<String?>(events: Observable<String?>.empty())
        Given(interactor, .fetchNews(text: .any, willReturn: completable))
        Given(interactor, .fetchSources(willReturn: completable))
        Given(interactor, .getNews(willReturn: .never()))

        let screenEvents = ListViewController.Events(itemSelected: givenEmptySelection, searchTextChanged: givenEmptySearch)
        let input = ListViewModel.Input(screenEvents: screenEvents)

        // Act
        let output = sut.map(from: input)

        // Assert
        Verify(interactor, .fetchNews(text: .any))
        Verify(interactor, .fetchSources())
        Verify(interactor, .getNews())

        guard (try? output.screenData.items.toBlocking(timeout: 1.0).first()) == nil else {
            fail("Items emitted unexpectedly")
            return
        }
    }

    func testSuccessfulScreenData() throws {
        // Arrange
        let givenEmptySelection = ControlEvent<IndexPath>(events: Observable<IndexPath>.empty())
        let givenEmptySearch = ControlEvent<String?>(events: Observable<String?>.empty())
        Given(interactor, .fetchNews(text: .any, willReturn: completable))
        Given(interactor, .fetchSources(willReturn: completable))
        Given(interactor, .getNews(willReturn: .just(mockArticles)))

        let screenEvents = ListViewController.Events(itemSelected: givenEmptySelection, searchTextChanged: givenEmptySearch)
        let input = ListViewModel.Input(screenEvents: screenEvents)

        // Act
        let output = sut.map(from: input)

        // Assert
        Verify(interactor, .fetchNews(text: .any))
        Verify(interactor, .fetchSources())
        Verify(interactor, .getNews())

        let items = try output.screenData.items.toBlocking(timeout: 1.0).first()

        expect(items?.count).to(equal(3))
        expect(items?[0].isFirst).to(beTrue())
        expect(items?[0].title).to(equal(mockArticles[0].title))
        expect(items?[1].isFirst).to(beFalse())
        expect(items?[1].title).to(equal(mockArticles[1].title))
        expect(items?[2].isFirst).to(beFalse())
        expect(items?[2].title).to(equal(mockArticles[2].title))
    }

    func testItemSelection() throws {
        // Arrange
        let givenSelection = ControlEvent<IndexPath>(events: Observable<IndexPath>.just(IndexPath(row: 0, section: 0)))
        let givenEmptySearch = ControlEvent<String?>(events: Observable<String?>.empty())
        Given(interactor, .fetchNews(text: .any, willReturn: completable))
        Given(interactor, .fetchSources(willReturn: completable))
        Given(interactor, .getNews(willReturn: .just(mockArticles)))
        Given(interactor, .selectArticle(.any, willReturn: completable))

        let screenEvents = ListViewController.Events(itemSelected: givenSelection, searchTextChanged: givenEmptySearch)
        let input = ListViewModel.Input(screenEvents: screenEvents)

        // Act
        let _ = sut.map(from: input)

        // Assert
        Verify(interactor, .fetchNews(text: .any))
        Verify(interactor, .fetchSources())
        Verify(interactor, .getNews())
        Verify(interactor, .selectArticle(.any))
    }

    func testSearch() throws {
        // Arrange
        let searchRelay = PublishRelay<String?>()
        let givenEmptySelection = ControlEvent<IndexPath>(events: Observable<IndexPath>.empty())
        let givenSearch = ControlEvent<String?>(events: searchRelay)
        Given(interactor, .fetchNews(text: .any, willReturn: completable))
        Given(interactor, .fetchSources(willReturn: completable))
        Given(interactor, .getNews(willReturn: .just(mockArticles)))

        let screenEvents = ListViewController.Events(itemSelected: givenEmptySelection, searchTextChanged: givenSearch)
        let input = ListViewModel.Input(screenEvents: screenEvents)

        // Act
        let _ = sut.map(from: input)
        searchRelay.accept(nil)

        // Assert
        Verify(interactor, .fetchNews(text: .value(nil)))
        Verify(interactor, .fetchSources())
        Verify(interactor, .getNews())
    }
}

// MARK: - Mock data
private extension ListViewModelTests {
    var mockArticles: [Article] {
        return [
            Article(title: "Article1",
                       articleURL: URL(string: "https://example1.com")!,
                       imageURL: URL(string: "https://example1.com/imageURL.png"),
                       content: "Content1",
                       category: "Category1",
                       language: "Language1",
                       publishedDate: Date()),
            Article(title: "Article2",
                       articleURL: URL(string: "https://example2.com")!,
                       imageURL: URL(string: "https://example2.com/imageURL.png"),
                       content: "Content2",
                       category: "Category2",
                       language: "Language2",
                       publishedDate: Date()),
            Article(title: "Article3",
                       articleURL: URL(string: "https://example3.com")!,
                       imageURL: URL(string: "https://example3.com/imageURL.png"),
                       content: "Content3",
                       category: "Category3",
                       language: "Language3",
                       publishedDate: Date())
        ]
    }
}

