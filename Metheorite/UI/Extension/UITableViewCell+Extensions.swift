//
//  UITableViewCell+Extensions.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
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
