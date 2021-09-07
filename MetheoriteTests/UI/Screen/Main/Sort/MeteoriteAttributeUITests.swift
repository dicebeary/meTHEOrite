//
//  MeteoriteAttributeUITests.swift
//  MetheoriteTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import XCTest
import Nimble
import SwiftyMocky
@testable import Domain
@testable import Theo

class MeteoriteAttributeUITests: XCTestCase {

    func testLocalization() throws {
        // Arrange
        let givenList = MeteoriteAttribute.allCases
        
        // Assert
        givenList.forEach { item in
            let actualLocalization = item.localizedAttribute
            switch item {
            case .location:
                expect(actualLocalization).to(equal(Localization.sortLocation))
            case .name:
                expect(actualLocalization).to(equal(Localization.sortName))
            case .mass:
                expect(actualLocalization).to(equal(Localization.sortMass))
            case .class:
                expect(actualLocalization).to(equal(Localization.sortClass))
            case .date:
                expect(actualLocalization).to(equal(Localization.sortDate))
            }
        }
    }

}
