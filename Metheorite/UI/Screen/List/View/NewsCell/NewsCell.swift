//
//  NewsCell.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit
import Kingfisher

final class NewsCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var highlightImageView: UIImageView!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

// MARK: - Binding data
extension NewsCell: ViewDataBinder {
    struct Data {
        let title: String
        let elapsedTime: String
        let image: URL?
        let isFirst: Bool
    }

    func bind(data: Data) {
        titleLabel.text = data.title
        elapsedTimeLabel.text = data.elapsedTime

        thumbnailImageView.isHidden = data.isFirst
        thumbnailImageView.kf.setImage(with: data.image)

        highlightImageView.isHidden = !data.isFirst
        highlightImageView.kf.setImage(with: data.image)
    }
}

// MARK: - Setup
private extension NewsCell {
    func setup() {
        elapsedTimeLabel.textColor = UIColor.lightGreyColor
        elapsedTimeLabel.font = FontFamily.LibreFranklin.medium.font(size: 14.0)

        titleLabel.textColor = UIColor.blackishColor
        titleLabel.font = FontFamily.LibreFranklin.medium.font(size: 16.0)
    }
}
