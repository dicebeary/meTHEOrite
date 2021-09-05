//
//  ListViewController.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import Domain
import RxDataSources
import RxSwift
import RxCocoa
import Resolver

typealias FavouriteToggle = (id: String, selected: Bool)

final class ListViewController: UIViewController, UISearchBarDelegate {
    // MARK: - ViewModel
    @Injected var viewModel: ListViewModel

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private let favouriteTapped = PublishRelay<FavouriteToggle>()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
    }
}

// MARK: - Binding data
extension ListViewController: ViewDataBinder {
    struct Data {
        let items: Driver<[MeteoriteCell.Data]>
    }

    func bind(data: Data) {
        data.items
            .drive(tableView.rx.items(cellIdentifier: MeteoriteCell.reuseIdentifier, cellType: MeteoriteCell.self)) { [weak self] index, element, cell in
                guard let self = self else { return }
                cell.bind(data: element)
                cell.events.favouriteTapped
                    .map { (element.id, $0) }
                    .bind(to: self.favouriteTapped)
                    .disposed(by: cell.bag)
            }.disposed(by: bag)
    }
}

// MARK: - Providing events
extension ListViewController: ViewEventListener {
    struct Events {
        let itemSelected: ControlEvent<IndexPath>
        let favouriteSelected: ControlEvent<FavouriteToggle>
    }

    var events: Events {
        return Events(itemSelected: tableView.rx.itemSelected,
                      favouriteSelected: .init(events: self.favouriteTapped))
    }
}

// MARK: - Setup
private extension ListViewController {
    func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.tableFooterView = UIView()
        tableView.register(MeteoriteCell.self)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }).disposed(by: bag)
    }

    func setupBindings() {
        let input = ListViewModel.Input(screenEvents: self.events)
        let output = viewModel.map(from: input)
        bind(data: output.screenData)
    }
}
