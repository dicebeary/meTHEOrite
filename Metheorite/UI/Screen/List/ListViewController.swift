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

final class ListViewController: UIViewController, UISearchBarDelegate {
    // MARK: - ViewModel
    @Injected var viewModel: ListViewModel

    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private var searchController: UISearchController!
    private let searchTextRelay = PublishRelay<String?>()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.navigate(from: self)
        setupTableView()
        setupNavigationBar()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.title = Localization.newsListTitle
//        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
//        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.title = ""
//        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
//        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK: - Binding data
extension ListViewController: ViewDataBinder {
    struct Data {
        let items: Driver<[MeteoriteCell.Data]>
    }

    func bind(data: Data) {
        data.items
            .drive(tableView.rx.items(cellIdentifier: MeteoriteCell.reuseIdentifier, cellType: MeteoriteCell.self)) { index, element, cell in
                cell.bind(data: element)
            }.disposed(by: bag)
    }
}

// MARK: - Providing events
extension ListViewController: ViewEventListener {
    struct Events {
        let itemSelected: ControlEvent<IndexPath>
        let searchTextChanged: ControlEvent<String?>
    }

    var events: Events {
        return Events(itemSelected: tableView.rx.itemSelected,
                      searchTextChanged: ControlEvent(events: searchTextRelay.asObservable()))
    }
}

// MARK: - Setup
private extension ListViewController {
    func setupBindings() {
        let input = ListViewModel.Input(screenEvents: self.events)
        let output = viewModel.map(from: input)
        bind(data: output.screenData)
    }

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

    func setupNavigationBar() {
        // Setup Title styles
//        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = [.font: FontFamily.Merriweather.bold.font(size: 17.0)]
//        self.tabBarController?.navigationController?.navigationBar.largeTitleTextAttributes = [.font: FontFamily.Merriweather.bold.font(size: 36.0)]
//
//        // Setup search bar functionalities
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        searchController.searchBar.sizeToFit()
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.hidesNavigationBarDuringPresentation = true
//        searchController.searchBar.placeholder = Localization.newsListSearchPlaceholder
//        self.definesPresentationContext = true
//        self.tabBarController?.navigationItem.searchController = searchController

//        searchController.searchBar.rx.text
//            .bind(to: searchTextRelay)
//            .disposed(by: bag)
//
//        searchController.searchBar.rx.cancelButtonClicked
//            .map { _ in return nil }
//            .bind(to: searchTextRelay)
//            .disposed(by: bag)
    }
}
