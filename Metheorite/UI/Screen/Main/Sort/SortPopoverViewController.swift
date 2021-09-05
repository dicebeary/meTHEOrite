//
//  SortPopoverViewController.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 05..
//

import UIKit
import Resolver
import RxSwift
import RxCocoa

protocol SortPopoverScreenDelegate: AnyObject {
    func itemSelected(viewController: UIViewController, at indexPath: IndexPath)
}

final class SortPopoverViewController: UIViewController, UITableViewDelegate {
    @Injected var viewModel: SortPopoverViewModel
    
    weak var screenDelegate: SortPopoverScreenDelegate?
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.alwaysBounceVertical = false
        tableView.isScrollEnabled = false

        setupBindings()
    }
}

private extension SortPopoverViewController {
    func setupBindings() {
        let output = viewModel.map(from: .init())
        
        output.items
            .drive(tableView.rx.items) { tableView, index, element in
                let cell = UITableViewCell()
                cell.textLabel?.text = element
                
                return cell
            }.disposed(by: bag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                self.screenDelegate?.itemSelected(viewController: self, at: indexPath)
            })
            .disposed(by: bag)
    }
}
