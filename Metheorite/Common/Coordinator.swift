//
//  Coordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 03..
//

import UIKit

// sourcery: AutoMockable
protocol Coordinator: AnyObject {
    /// Container of child containers
    var childCoordinators: [Coordinator] { get set }

    /// Initial point of given coordinator
    func start()
}
