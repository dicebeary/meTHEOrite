//
//  ViewModelManipulator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit

protocol ViewModelMappable {
    associatedtype Input
    associatedtype Output
    func map(from input: Input) -> Output
}
