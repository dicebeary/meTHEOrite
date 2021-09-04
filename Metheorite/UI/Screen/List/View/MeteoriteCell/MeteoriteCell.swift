//
//  MeteoriteCell.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit
import Kingfisher

final class MeteoriteCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

// MARK: - Binding data
extension MeteoriteCell: ViewDataBinder {
    struct Data {
        let title: String
    }

    func bind(data: Data) {
        titleLabel.text = data.title
    }
}

// MARK: - Setup
private extension MeteoriteCell {
    func setup() {

        titleLabel.textColor = UIColor.blackishColor
        titleLabel.font = .systemFont(ofSize: 16.0)
    }
}
