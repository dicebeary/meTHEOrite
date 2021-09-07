//
//  Single+ExtensionTests.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import XCTest
import Nimble
import RxSwift
import SwiftyMocky
@testable import Core

class SingleExtensionTests: XCTestCase {
    var cache: CacheableMock!
    var sut: Single<CodableEnum>!

    override func setUp() {
        super.setUp()
        cache = CacheableMock()
        sut = Single<CodableEnum>.just(.unknown)
    }

    override func tearDown() {
        cache = nil
        sut = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension SingleExtensionTests {
    func testStore() {
        // Arrange
        let givenKey = "testKey"
        
        Matcher.default.register(CodableEnum.self) { $0 == $1 }
        
        // Act
        sut.cacheResponse(to: cache, as: givenKey)
            .subscribe()
            .dispose()
        
        // Assert
        Verify(cache, 1, .save(object: .value(CodableEnum.unknown), forKey: .value(givenKey)))
    }

    func testRestoreIfError() {
        // Arrange
        let givenKey = "testKey"
        sut = .error(RxError.unknown)
        
        Matcher.default.register(CodableEnum.Type.self) { $0 == $1 }
        
        // Act
        sut.restoreResponseIfError(from: cache, as: givenKey)
            .subscribe()
            .dispose()
        
        // Assert
        Verify(cache, 1, .load(type: .value(CodableEnum.self), forKey: .value(givenKey)))
    }

    func testUnRestore() {
        // Arrange
        let givenKey = "testKey"
        
        Matcher.default.register(CodableEnum.Type.self) { $0 == $1 }
        
        // Act
        sut.restoreResponseIfError(from: cache, as: givenKey)
            .subscribe()
            .dispose()
        
        // Assert
        Verify(cache, 0, .load(type: .value(CodableEnum.self), forKey: .value(givenKey)))
    }
}

enum CodableEnum: String, Codable, Equatable {
    case unknown
}
