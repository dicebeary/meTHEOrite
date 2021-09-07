//
//  ContentCoordinatorTests.swift
//  MetheoriteTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import XCTest
import Nimble
import RxSwift
import RxBlocking
import Resolver
import SwiftyMocky
@testable import Domain
@testable import Theo

class ContentCoordinatorTests: XCTestCase {
    var sut: ContentCoordinator!
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var mainVC: MainViewController!

    override func setUp() {
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        Given(interactor, .fetchLandings(willReturn: .empty()))
        Given(interactor, .fetchFavourites(willReturn: .empty()))
        Given(interactor, .landings(getter: .just([])))
        Given(interactor, .favourites(getter: .just([])))

        mainVC = MainViewController()
        
        sut = ContentCoordinator(containerViewController: mainVC)
    }
    
    override func tearDown() {
        mainVC = nil
        interactor = nil
        sut = nil
    }
    
    func testStart() {
        // Arrange
        Given(interactor, .sortingTypes(getter: .just([])))

        // Act
        sut.start()
        
        //Assert
        let listScreen = mainVC.children
            .first(where: { $0 is ListViewController })

        let mapScreen = mainVC.children
            .first(where: { $0 is ListViewController })

        expect(listScreen).notTo(beNil())
        expect(mapScreen).notTo(beNil())
        expect(self.sut.childCoordinators.count).to(equal(0))
    }

    func testSortItemSelected() {
        // Arrange
        let givenIndexPath = IndexPath(row: 0, section: 0)
        let givenSortingTypes = MeteoriteAttribute.allCases
        
        Given(interactor, .sortingTypes(getter: .just(givenSortingTypes)))
        Given(interactor, .sortMeteorite(by: .any, willReturn: .empty()))

        // Act
        sut.start()
        sut.itemSelected(viewController: mainVC, at: givenIndexPath)
        
        //Assert
        Verify(interactor, .sortMeteorite(by: .value(givenSortingTypes[0])))
    }
}
