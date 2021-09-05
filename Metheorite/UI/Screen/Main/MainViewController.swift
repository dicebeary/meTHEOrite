//
//  MainViewController.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 01..
//

import UIKit
import RxSwift
import Resolver

protocol MainScreenDelegate: AnyObject {
    func segmentDidChange(index: Int)
    func sortButtonTapped(sender: UIBarButtonItem)
}

class MainViewController: UIViewController {
    
    @Injected var viewModel: MainViewModel
    
    weak var screenDelegate: MainScreenDelegate?

    let segmentedControl = UISegmentedControl(items: [Localization.listTitle, Localization.mapTitle])

    var sortButton: UIBarButtonItem!
    var refreshButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupBindings()
    }
    
    @objc private func sortButtonTapped(_ sender: UIBarButtonItem) {
        screenDelegate?.sortButtonTapped(sender: sender)
    }

    @objc private func segmentDidChange(_ sender: UISegmentedControl) {
        screenDelegate?.segmentDidChange(index: sender.selectedSegmentIndex)
        if sender.selectedSegmentIndex == 0 {
            self.title = Localization.listTitle
        } else {
            self.title = Localization.mapTitle
        }
    }
}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonTapped(_:)))
        refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: nil)

        segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        
        segmentedControl.frame.size = CGSize(width: 240, height: 30)
        segmentedControl.selectedSegmentIndex = 0

        navigationItem.titleView = segmentedControl
        navigationItem.leftBarButtonItem = sortButton
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    func setupBindings() {
        let input = MainViewModel.Input(refreshButtonTapped: refreshButton.rx.tap)
        let _ = viewModel.map(from: input)
    }
}
