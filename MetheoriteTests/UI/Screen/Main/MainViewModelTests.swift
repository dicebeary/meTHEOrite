//
//  MainViewModelTests.swift
//  MetheoriteTests
//
//  Created by Vajda Kristóf on 2021. 09. 06..
//

import XCTest
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import SwiftyMocky
import Resolver
@testable import Domain
@testable import Theo

class MainViewModelTests: XCTestCase {
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: MainViewModel!

    override func setUp() {
        super.setUp()
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        sut = MainViewModel()
    }

    override func tearDown() {
        interactor = nil
        sut = nil
        super.tearDown()
    }
}

extension MainViewModelTests {
    func testIdleState() {
        // Arrange
        Given(interactor, .fetchLandings(willReturn: .empty()))
        Given(interactor, .fetchFavourites(willReturn: .empty()))
        let refreshEvent = ControlEvent<Void>(events: Observable<Void>.just(()))
        
        // Act
        let _ = sut.map(from: .init(refreshButtonTapped: refreshEvent))
        
        // Assert
        Verify(interactor, .fetchFavourites())
        Verify(interactor, .fetchLandings())
    }

    func testRefreshButtonTapped() {
        // Arrange
        Given(interactor, .fetchLandings(willReturn: .empty()))
        Given(interactor, .fetchFavourites(willReturn: .empty()))

        let refreshEvent = ControlEvent<Void>(events: Observable<Void>.just(()))
        
        // Act
        let _ = sut.map(from: .init(refreshButtonTapped: refreshEvent))
        
        // Assert
        Verify(interactor, 2, .fetchLandings())
    }
}
