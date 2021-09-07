//
//  ViewModelManipulator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit

/// Proxy protocol for gather events and emit data to UI
protocol ViewModelMappable {
    associatedtype Input
    associatedtype Output
    func map(from input: Input) -> Output
}
