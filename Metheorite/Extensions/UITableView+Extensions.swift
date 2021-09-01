//
//  UITableView+Extensions.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
