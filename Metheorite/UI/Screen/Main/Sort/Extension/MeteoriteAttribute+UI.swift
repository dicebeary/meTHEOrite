//
//  MeteoriteAttribute+UI.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import Domain

extension MeteoriteAttribute {
    var localizedAttribute: String {
        switch self {
        case .location:
            return Localization.sortLocation
        case .name:
            return Localization.sortName
        case .mass:
            return Localization.sortMass
        case .class:
            return Localization.sortClass
        case .date:
            return Localization.sortDate
        }
    }
}
