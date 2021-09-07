//
//  ViewDataBinder.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

/// Domain to UI mapping contract
protocol ViewDataBinder: AnyObject {
    associatedtype Data

    func bind(data: Data)
}
