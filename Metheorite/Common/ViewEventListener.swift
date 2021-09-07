//
//  ViewEventListener.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

/// Event collector from UI
protocol ViewEventListener: AnyObject {
    associatedtype Events

    var events: Events { get }
}
