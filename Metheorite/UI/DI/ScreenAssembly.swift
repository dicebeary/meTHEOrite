//
//  ScreenAssembly.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import Domain
import Resolver

public extension Resolver {
    static func assembleScreen() {
        register { ListViewModel() }
        register { DetailsViewModel() }
        register { Navigator() }
            .implements(NavigatorInterface.self)
    }
}
