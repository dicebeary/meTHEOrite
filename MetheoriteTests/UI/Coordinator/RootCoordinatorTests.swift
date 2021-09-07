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
    var landingInteractor: MeteoriteLandingInteractorInterfaceMock!
    var userInteractor: UserInteractorInterfaceMock!
    var sut: RootCoordinator!
    var window: UIWindow!

    override func setUp() {
        landingInteractor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.landingInteractor }
            .implements(MeteoriteLandingInteractorInterface.self)

        userInteractor = UserInteractorInterfaceMock()
        Resolver.register { self.userInteractor }
            .implements(UserInteractorInterface.self)


        Given(landingInteractor, .fetchLandings(willReturn: .empty()))
        Given(landingInteractor, .fetchFavourites(willReturn: .empty()))
        Given(landingInteractor, .landings(getter: .just([])))
        Given(landingInteractor, .favourites(getter: .just([])))
        Given(userInteractor, .userLocation(getter: .just(nil)))

        window = UIWindow()
        sut = RootCoordinator(window: window)
    }
    
    override func tearDown() {
        landingInteractor = nil
        userInteractor = nil
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
