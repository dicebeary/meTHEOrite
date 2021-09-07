//
//  VerySimpleCacheTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import XCTest
import Nimble
import SwiftyMocky
@testable import Core

class VerySimpleCacheTests: XCTestCase {
    var userDefaults: UserDefaults!
    var sut: VerySimpleCache!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "TestTarget")

        sut = VerySimpleCache(userDefaults: userDefaults)
    }

    override func tearDown() {
        userDefaults.removePersistentDomain(forName: "TestTarget")
        userDefaults = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension VerySimpleCacheTests {
    func testSave() throws {
        // Arrange
        let givenKey = "testKey"
        let givenObject = CodableObject.mockValue()
        
        // Act
        sut.save(object: givenObject, forKey: givenKey)
        
        // Assert
        let data = userDefaults.data(forKey: givenKey)
        let actualObject = try JSONDecoder().decode(CodableObject.self, from: data!)
        expect(actualObject).to(equal(givenObject))
    }

    func testLoad() throws {
        // Arrange
        let givenKey = "testKey"
        let givenObject = CodableObject.mockValue()
        let givenData = try JSONEncoder().encode(givenObject)
        userDefaults.setValue(givenData, forKey: givenKey)

        // Act
        let actualObject = sut.load(type: CodableObject.self, forKey: givenKey)
        
        // Assert
        expect(actualObject).to(equal(givenObject))
    }

    func testLoadIfEmpty() throws {
        // Arrange
        let givenKey = "testKey"

        // Act
        let actualObject = sut.load(type: CodableObject.self, forKey: givenKey)
        
        // Assert
        expect(actualObject).to(beNil())
    }
}

private struct CodableObject: Codable, Equatable {
    let id: String
    let number: Int
    let date: Date
    
    static func mockValue() -> CodableObject {
        return CodableObject(id: "1", number: 2, date: Date())
    }
}
