//
//  MeteoriteLandingInteractorTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import XCTest
import Nimble
import RxBlocking
import SwiftyMocky
import Resolver
@testable import Core
@testable import Domain

class MeteoriteLandingInteractorTests: XCTestCase {
    var service: MeteoriteLandingServiceInterfaceMock!
    var cacheable: CacheableMock!
    var sut: MeteoriteLandingInteractorInterface!

    override func setUp() {
        super.setUp()

        cacheable = CacheableMock()
        service = MeteoriteLandingServiceInterfaceMock()

        Resolver.register { self.cacheable }
            .implements(Cacheable.self)
        Resolver.register { self.service }
            .implements(MeteoriteLandingServiceInterface.self)

        sut = MeteoriteLandingInteractor()        
    }

    override func tearDown() {
        service = nil
        cacheable = nil
        sut = nil
        super.tearDown()
    }

    func testSuccessfulFetchLandings() throws {
        // Arrange
        Given(service, .getMeteoriteLandings(willReturn: .just(mockLandings)))

        // Act
        sut.fetchLandings()
            .subscribe()
            .dispose()
        
        let landings = try sut.landings.toBlocking(timeout: 1.0).first()

        // Assert
        expect(landings?.count).to(equal(3))
        expect(landings?[0].id).to(equal("123455"))
        expect(landings?[1].id).to(equal("123456"))
        expect(landings?[2].id).to(equal("123457"))
        Verify(service, 1, .getMeteoriteLandings())
    }

    func testSuccessfulFetchFavourites() throws {
        // Arrange
        let givenFavourites: [String] = ["test1", "test2", "test3"]
        Given(cacheable, .load(type: .value([String].self), forKey: .any, willReturn: givenFavourites))

        Matcher.default.register([String].Type.self) { $0 == $1 }

        // Act
        sut.fetchFavourites()
            .subscribe()
            .dispose()

        let favourites = try sut.favourites.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(favourites).to(equal(givenFavourites))
        Verify(cacheable, 1, .load(type: .value([String].self), forKey: .any))
    }

    func testUnsuccessfulFetchFavourites() throws {
        // Arrange
        Given(cacheable, .load(type: .value([String].self), forKey: .any, willReturn: nil))

        Matcher.default.register([String].Type.self) { $0 == $1 }

        // Act
        sut.fetchFavourites()
            .subscribe()
            .dispose()

        let favourites = try sut.favourites.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(favourites).to(equal([]))
        Verify(cacheable, 1, .load(type: .value([String].self), forKey: .any))
    }

    func testSortingTypes() throws {
        // Arrange
        let givenTypes = MeteoriteAttribute.allCases

        // Act
        let types = try sut.sortingTypes.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(types).to(equal(givenTypes))
    }

    func testSortMeteorites() throws {
        // Arrange
        Given(service, .getMeteoriteLandings(willReturn: .just(mockLandings)))
        
        // Act
        sut.fetchLandings()
            .subscribe()
            .dispose()
        
        sut.sortMeteorite(by: .mass)
            .subscribe()
            .dispose()
        
        let landings = try sut.landings.toBlocking(timeout: 1.0).first()

        // Assert
        expect(landings?[0].mass).to(equal(10))
        expect(landings?[1].mass).to(equal(100))
        expect(landings?[2].mass).to(equal(1000))
    }

    func testSaveFavourite() throws {
        // Arrange
        let givenId = "saveId"
        Given(cacheable, .load(type: .any, forKey: .any, willReturn: ["testId"]))

        Matcher.default.register([String]?.self) { $0 == $1 }

        // Act
        sut.fetchFavourites()
            .subscribe()
            .dispose()
        
        sut.saveFavourite(id: givenId)
            .subscribe()
            .dispose()

        // Assert
        Verify(cacheable, 1, .save(object: .value(["testId", "saveId"]), forKey: .any))
    }

    func testRemoveFavourite() throws {
        // Arrange
        let givenId = "removeId"
        let givenList: [String]? = ["saveId", "testId"]
        Given(cacheable, .load(type: .any, forKey: .any, willReturn: ["saveId", givenId, "testId"]))
        
        Matcher.default.register([String]?.self) { $0 == $1 }

        // Act
        sut.fetchFavourites()
            .subscribe()
            .dispose()
        
        sut.removeFavourite(id: givenId)
            .subscribe()
            .dispose()
        
        let favourites = try sut.favourites.toBlocking(timeout: 1.0).first()

        // Assert
        expect(favourites).to(equal(givenList))
        Verify(cacheable, .save(object: .value(givenList), forKey: .any))
    }
}

// MARK: - Mock data
private extension MeteoriteLandingInteractorTests {
    var mockLandings: [MeteoriteLandingApiModel] {
        [
            MeteoriteLandingApiModel(name: "teszt1",
                             id: "123455",
                             nametype: "type",
                             recclass: "C1",
                             mass: "1000",
                             fall: "Fell",
                             year: "1910-01-01T10:10:10.000",
                             reclat: "12.3456",
                             reclong: "65.4321",
                             geolocation: nil),
            MeteoriteLandingApiModel(name: "teszt2",
                             id: "123456",
                             nametype: "type",
                             recclass: "C1",
                             mass: "10",
                             fall: "Fell",
                             year: "1910-01-01T10:10:10.000",
                             reclat: "12.3456",
                             reclong: "65.4321",
                             geolocation: nil),
            MeteoriteLandingApiModel(name: "teszt3",
                             id: "123457",
                             nametype: "type",
                             recclass: "C1",
                             mass: "100",
                             fall: "Fell",
                             year: "1910-01-01T10:10:10.000",
                             reclat: "12.3456",
                             reclong: "65.4321",
                             geolocation: nil),
        ]
    }
}
