//
//  UserInteractorTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import XCTest
import Nimble
import CoreLocation
import RxBlocking
import SwiftyMocky
import Resolver
@testable import Core
@testable import Domain

class UserInteractorTests: XCTestCase {

    var locationManager: LocationManagingMock!
    var sut: UserInteractor!
    
    override func setUp() {
        super.setUp()
        locationManager = LocationManagingMock()

        Resolver.register { self.locationManager }
            .implements(LocationManaging.self)

        sut = UserInteractor()
    }

    override func tearDown() {
        locationManager = nil
        sut = nil
        super.tearDown()
    }

    func testLocationPassing() throws {
        // Arrange
        Given(locationManager, .userLocation(getter: .just(CLLocation(latitude: CLLocationDegrees(10), longitude: CLLocationDegrees(20)))))

        // Act
        let location = try sut.userLocation.toBlocking(timeout: 1.0).first()

        // Assert
        expect(location??.latitude).to(equal(10))
        expect(location??.longitude).to(equal(20))
        Verify(locationManager, 1, .userLocation)
    }
}
