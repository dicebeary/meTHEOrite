//
//  UITableViewCell+Extensions.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit

extension UITableViewCell {
    static var nibName: String {
        return String(describing: self)
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
