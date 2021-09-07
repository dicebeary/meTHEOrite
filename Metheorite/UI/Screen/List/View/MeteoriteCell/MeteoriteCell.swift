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
    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var massLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var favouriteButton: UIButton!
    
    private var isFavourite: Bool = false
    
    var id: String!
    var bag = DisposeBag()
    
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
        let mass: String
        let date: String
        let isFavourite: Bool
    }

    func bind(data: Data) {
        self.id = data.id
        titleLabel.text = data.title
        massLabel.text = data.mass
        dateLabel.text = data.date
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
