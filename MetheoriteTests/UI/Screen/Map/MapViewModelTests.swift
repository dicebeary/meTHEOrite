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
    var interactor: MeteoriteLandingInteractorInterfaceMock!
    var sut: MapViewModel!

    override func setUp() {
        super.setUp()
        interactor = MeteoriteLandingInteractorInterfaceMock()
        Resolver.register { self.interactor }
            .implements(MeteoriteLandingInteractorInterface.self)
        sut = MapViewModel()
    }

    override func tearDown() {
        interactor = nil
        sut = nil
        super.tearDown()
    }
}

extension MapViewModelTests {
    func testIdleState() throws {
        // Arrange
        Given(interactor, .landings(getter: .just(mockLandings)))
        
        // Act
        let output = sut.map(from: .init())
        
        let annotations = try output.pins.toBlocking(timeout: 1.0).first()
        // Assert
        expect(annotations?.count).to(equal(3))
        Verify(interactor, .landings)
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
