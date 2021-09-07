//
//  MeteoriteLandingMapperTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import XCTest
import Nimble
import SwiftyMocky
@testable import Core

class MeteoriteLandingMapperTests: XCTestCase {}

// MARK: - Tests
extension MeteoriteLandingMapperTests {
    func testMapDefault() throws {
        // Arrange
        let givenApiModel = ApiModelFactory.defaultModel()
        
        // Act
        let mappedModel = MeteoriteLandingMapper.map(from: [givenApiModel])
        
        // Assert
        expect(mappedModel.first?.id).to(equal("12345"))
        expect(mappedModel.first?.fall).to(equal(.found))
        expect(mappedModel.first?.meteoriteClass).to(equal("T5"))
        expect(mappedModel.first?.name).to(equal("Test"))
        expect(mappedModel.first?.location?.longitude).to(equal(12.345))
        expect(mappedModel.first?.location?.latitude).to(equal(54.321))
        expect(mappedModel.first?.mass).to(equal(100))
        expect(mappedModel.first?.year).to(equal(mockDate))
    }

    func testMapMissing() throws {
        // Arrange
        let givenApiModel = ApiModelFactory.emptyishModel()
        
        // Act
        let mappedModel = MeteoriteLandingMapper.map(from: [givenApiModel])
        
        // Assert
        expect(mappedModel.first?.id).to(equal("12345"))
        expect(mappedModel.first?.fall).to(beNil())
        expect(mappedModel.first?.meteoriteClass).to(equal("T5"))
        expect(mappedModel.first?.name).to(equal("Test"))
        expect(mappedModel.first?.location?.longitude).to(equal(12.345))
        expect(mappedModel.first?.location?.latitude).to(equal(54.321))
        expect(mappedModel.first?.mass).to(beNil())
        expect(mappedModel.first?.year).to(equal(mockDate))
    }

    func testMapFell() throws {
        // Arrange
        let givenApiModel = ApiModelFactory.notFoundModel()
        
        // Act
        let mappedModel = MeteoriteLandingMapper.map(from: [givenApiModel])
        
        // Assert
        expect(mappedModel.first?.fall).to(equal(.fell))
    }
}

extension MeteoriteLandingMapperTests {
    var mockDate: Date {
        return Date(timeIntervalSince1970: 0)
    }
}

fileprivate enum ApiModelFactory {
    static func defaultModel() -> MeteoriteLandingApiModel {
        return MeteoriteLandingApiModel(
            name: "Test",
            id: "12345",
            nametype: "asd",
            recclass: "T5",
            mass: "100",
            fall: "Found",
            year: "1970-01-01T01:00:00.000",
            reclat: "123.45",
            reclong: "12345.67",
            geolocation: GeoLocationApiModel(type: "type",
                                             coordinates: [12.345, 54.321])
        )
    }

    static func notFoundModel() -> MeteoriteLandingApiModel {
        return MeteoriteLandingApiModel(
            name: "Test",
            id: "12345",
            nametype: "asd",
            recclass: "T5",
            mass: "100",
            fall: "Fell",
            year: "1970-01-01T01:00:00.000",
            reclat: "123.45",
            reclong: "12345.67",
            geolocation: GeoLocationApiModel(type: "type",
                                             coordinates: [12.345, 54.321])
        )
    }

    static func emptyishModel() -> MeteoriteLandingApiModel {
        return MeteoriteLandingApiModel(
            name: "Test",
            id: "12345",
            nametype: "asd",
            recclass: "T5",
            mass: nil,
            fall: "Fod",
            year: "1970-01-01T01:00:00.000",
            reclat: nil,
            reclong: nil,
            geolocation: GeoLocationApiModel(type: "type",
                                             coordinates: [12.345, 54.321])
        )
    }
}
