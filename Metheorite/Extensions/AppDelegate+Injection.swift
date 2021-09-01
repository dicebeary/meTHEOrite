//
//  AppDelegate+Injection.swift
//  Placeboop
//
//  Created by Vajda Kristóf on 2021. 08. 19..
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
