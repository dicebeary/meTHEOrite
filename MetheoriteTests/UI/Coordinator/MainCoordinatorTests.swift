//
//  MainCoordinatorTests.swift
//  MetheoriteTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import XCTest
import Nimble
import SwiftyMocky
import Resolver
@testable import Domain
@testable import Theo

class MainCoordinatorTests: XCTestCase {
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: MainCoordinator!
    var navVC: UINavigationController!

    override func setUp() {
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        Given(interactor, .fetchLandings(willReturn: .empty()))
        Given(interactor, .fetchFavourites(willReturn: .empty()))
        Given(interactor, .landings(getter: .just([])))
        Given(interactor, .favourites(getter: .just([])))

        navVC = UINavigationController()
        sut = MainCoordinator(navigationController: navVC)
    }
    
    override func tearDown() {
        navVC = nil
        interactor = nil
        sut = nil
    }
    
    func testStart() {
        // Act
        sut.start()
        
        //Assert
        expect(self.navVC.viewControllers[0] is MainViewController).to(beTrue())
        expect(self.sut.childCoordinators.count).to(equal(1))
        expect(self.sut.childCoordinators[0] is ContentCoordinator).to(beTrue())
    }
}
