//
//  Coordinator.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 03..
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}
