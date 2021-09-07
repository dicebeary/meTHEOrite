//
//  MapViewModelTests.swift
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

class MapViewModelTests: XCTestCase {
    var landingInteractor: MeteoriteLandingInteractorInterfaceMock!
    var userInteractor: UserInteractorInterfaceMock!
    var sut: MapViewModel!

    override func setUp() {
        super.setUp()
        landingInteractor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.landingInteractor }
            .implements(MeteoriteLandingInteractorInterface.self)
        
        userInteractor = UserInteractorInterfaceMock()
        Resolver.register { self.userInteractor }
            .implements(UserInteractorInterface.self)

        sut = MapViewModel()
    }

    override func tearDown() {
        landingInteractor = nil
        userInteractor = nil
        sut = nil
        super.tearDown()
    }
}

extension MapViewModelTests {
    func testIdleState() throws {
        // Arrange
        Given(landingInteractor, .landings(getter: .just(mockLandings)))
        Given(userInteractor, .userLocation(getter: .just(nil)))
        
        // Act
        let output = sut.map(from: .init())
        
        let annotations = try output.pins.toBlocking(timeout: 1.0).first()
        // Assert
        expect(annotations?.count).to(equal(3))
        Verify(landingInteractor, .landings)
    }

    func testLocation() throws {
        // Arrange
        let givenLocation = Location(longitude: 10, latitude: 20)
        Given(landingInteractor, .landings(getter: .just(mockLandings)))
        Given(userInteractor, .userLocation(getter: .just(givenLocation)))
        
        // Act
        let output = sut.map(from: .init())
        
        let location = try output.userLocation.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(location?.latitude).to(equal(20))
        expect(location?.longitude).to(equal(10))
    }
}

private extension MapViewModelTests {
    var mockLandings: [MeteoriteLanding] {
        [
            MeteoriteLanding(name: "teszt1",
                             id: "123455",
                             meteoriteClass: "C1",
                             mass: 1000,
                             fall: .fell,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2020, latitude: 40.4040)),
            MeteoriteLanding(name: "teszt2",
                             id: "123456",
                             meteoriteClass: "C1",
                             mass: 10,
                             fall: .found,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2021, latitude: 40.4041)),
            MeteoriteLanding(name: "teszt3",
                             id: "123457",
                             meteoriteClass: "C1",
                             mass: 100,
                             fall: .fell,
                             year: Date(),
                             location: GeoLocation(longitude: 20.2022, latitude: 40.4042)),
        ]
    }
}
