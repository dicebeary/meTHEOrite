//
//  Navigator.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import UIKit

// sourcery: AutoMockable
protocol NavigatorInterface {
    func push(from viewController: UIViewController, to identifier: String)
}

final class Navigator: NavigatorInterface {

    func push(from viewController: UIViewController, to identifier: String) {
        guard let pushingVC = viewController.storyboard?.instantiateViewController(identifier: identifier) else {
            return
        }
        viewController.navigationController?.pushViewController(pushingVC, animated: true)
    }
}
