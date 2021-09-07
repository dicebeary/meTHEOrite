//
//  RootCoordinatorTests.swift
//  MetheoriteTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import XCTest
import Nimble
import Resolver
import SwiftyMocky
@testable import Domain
@testable import Theo

class RootCoordinatorTests: XCTestCase {
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: RootCoordinator!
    var window: UIWindow!

    override func setUp() {
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        Given(interactor, .fetchLandings(willReturn: .empty()))
        Given(interactor, .fetchFavourites(willReturn: .empty()))
        Given(interactor, .landings(getter: .just([])))
        Given(interactor, .favourites(getter: .just([])))

        window = UIWindow()
        sut = RootCoordinator(window: window)
    }
    
    override func tearDown() {
        interactor = nil
        window = nil
        sut = nil
    }
    
    func testStart() {
        // Act
        sut.start()
        
        //Assert
        expect(self.window.rootViewController is UINavigationController).to(beTrue())
        expect(self.sut.childCoordinators.count).to(equal(1))
        expect(self.sut.childCoordinators[0] is MainCoordinator).to(beTrue())
    }
}
