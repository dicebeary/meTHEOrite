//
//  ViewEventListener.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

protocol ViewEventListener: class {
    associatedtype Events

    var events: Events { get }
}
