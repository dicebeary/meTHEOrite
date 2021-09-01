//
//  ViewEventListener.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 16..
//

import Foundation

protocol ViewEventListener: class {
    associatedtype Events

    var events: Events { get }
}
