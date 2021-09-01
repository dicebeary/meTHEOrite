//
//  StubbedResponse.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Foundation

struct StubbedResponse {
    static func getResponse(from jsonFile: String) -> Data {
        if let path = Bundle(for: BundleToken.self).path(forResource: jsonFile, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            return data
        }

        return Data()
    }
}

private class BundleToken {}
