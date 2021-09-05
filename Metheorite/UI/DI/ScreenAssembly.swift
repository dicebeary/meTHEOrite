//
//  ScreenAssembly.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Domain
import Resolver

public extension Resolver {
    static func assembleScreen() {
        register { MainViewModel() }
        register { SortPopoverViewModel() }
        register { ListViewModel() }
        register { MapViewModel() }
    }
}
