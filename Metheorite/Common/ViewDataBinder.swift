//
//  ViewDataBinder.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

protocol ViewDataBinder: class {
    associatedtype Data

    func bind(data: Data)
}
