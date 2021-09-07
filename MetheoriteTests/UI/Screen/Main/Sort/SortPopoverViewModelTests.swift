//
//  SortPopoverViewModelTests.swift
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

class SortPopoverViewModelTests: XCTestCase {
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: SortPopoverViewModel!

    override func setUp() {
        super.setUp()
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        sut = SortPopoverViewModel()
    }

    override func tearDown() {
        interactor = nil
        sut = nil
        super.tearDown()
    }
}

extension SortPopoverViewModelTests {
    func testIdleState() throws {
        // Arrange
        let givenList = MeteoriteAttribute.allCases
        let givenLocalizedList = givenList.map { $0.localizedAttribute }

        Given(interactor, .sortingTypes(getter: .just(givenList)))
        // Act
        let output = sut.map(from: .init())
        
        // Assert
        let items = try output.items.toBlocking(timeout: 1.0).first()
        
        expect(items).to(equal(givenLocalizedList))
        Verify(interactor, .sortingTypes)
    }
}
