//
//  ViewModelManipulator.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import UIKit

protocol ViewModelManipulator {
    associatedtype Input
    associatedtype Output
    func map(from input: Input) -> Output
    func navigate(from viewController: UIViewController)
}
