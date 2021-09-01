//
//  DetailsViewModelTests.swift
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

class DetailsViewModelTests: XCTestCase {
    var interactor: NewsInteractorInterfaceMock!
    var sut: DetailsViewModel!

    let completable = Completable.create { completable -> Disposable in
        completable(.completed)
        return Disposables.create()
    }


    override func setUp() {
        super.setUp()

        interactor = NewsInteractorInterfaceMock()
        sut = DetailsViewModel(newsInteractor: interactor)
    }

    override func tearDown() {
        interactor = nil
        sut = nil
        super.tearDown()
    }

    func testSuccessfulScreenData() throws {
        // Arrange
        Given(interactor, .getSelectedArticle(willReturn: .just(mockArticle)))

        // Act
        let output = sut.map(from: DetailsViewModel.Input())

        // Assert
        Verify(interactor, .getSelectedArticle())

        let title = try output.screenData.title.toBlocking(timeout: 1.0).first()
        let category = try output.screenData.category.toBlocking(timeout: 1.0).first()
        let language = try output.screenData.language.toBlocking(timeout: 1.0).first()
        let imageUrl = try output.screenData.imageUrl.toBlocking(timeout: 1.0).first()

        expect(title).to(equal(mockArticle.title))
        expect(category).to(equal(mockArticle.category?.uppercased()))
        expect(language).to(equal(mockArticle.language?.uppercased()))
        expect(imageUrl??.absoluteString).to(equal(mockArticle.imageURL?.absoluteString))
    }
}

// MARK: - Mock data
private extension DetailsViewModelTests {
    var mockArticle: Article {
        return Article(title: "Article1",
                       articleURL: URL(string: "https://example1.com")!,
                       imageURL: URL(string: "https://example1.com/imageURL.png"),
                       content: "Content1",
                       category: "Category1",
                       language: "Language1",
                       publishedDate: Date())
    }
}


