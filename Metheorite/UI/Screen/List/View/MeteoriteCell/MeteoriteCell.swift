//
//  MeteoriteCell.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class MeteoriteCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var isFavourite: Bool = false
    
    var id: String!
    var bag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        isFavourite = !isFavourite
    }
}

// MARK: - Binding data
extension MeteoriteCell: ViewDataBinder {
    struct Data {
        let id: String
        let title: String
        let isFavourite: Bool
    }

    func bind(data: Data) {
        self.id = data.id
        titleLabel.text = data.title
        isFavourite = data.isFavourite

        let favouriteImage = isFavourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favouriteButton.setImage(favouriteImage, for: .normal)
    }
}

// MARK: - Event handling
extension MeteoriteCell: ViewEventListener {
    struct Events {
        let favouriteTapped: ControlEvent<Bool>
    }

    var events: Events {
        let isFavourite = self.isFavourite
        let tap = favouriteButton.rx.tap
            .map { isFavourite }
        return Events(favouriteTapped: .init(events: tap))
    }
}

// MARK: - Setup
private extension MeteoriteCell {
    func setup() {
        titleLabel.textColor = UIColor.blackishColor
        titleLabel.font = .systemFont(ofSize: 16.0)
    }
}
