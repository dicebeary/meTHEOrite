//
//  NewsError.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

public enum NewsError: Error {
    case parseError(propertyName: String)
    case moyaError(code: String, message: String)
}
