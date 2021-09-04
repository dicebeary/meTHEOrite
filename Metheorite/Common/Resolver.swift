//
//  AppDelegate+Injection.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Resolver
import Moya
import Core

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        Resolver.assembleCore()
        Resolver.assembleScreen()
    }
}
