//
//  AppInfo.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Foundation

struct AppInfo {
    private init() {}

    static let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    static let environment: Environment = AppInfo.appName?.contains("Mock") ?? false ? .mock : .prod
}
