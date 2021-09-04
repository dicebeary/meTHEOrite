//
//  ViewDataBinder.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

protocol ViewDataBinder: class {
    associatedtype Data

    func bind(data: Data)
}
