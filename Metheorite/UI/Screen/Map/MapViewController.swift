//
//  MapViewController.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import RxSwift
import RxCocoa
import Resolver
import MapKit

final class MapViewController: UIViewController {
    @Injected var viewModel: MapViewModel

    private var navigationBarShadowImage: UIImage?
    private var navigationBarBackgroundImage: UIImage?
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        setupLocalization()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - Setup Layout
private extension MapViewController {
    func setupBindings() {
        let output = viewModel.map(from: .init())
//        self.bind(data: output.screenData)
    }

    func setupLocalization() {
    }

    func setupStyle() {
    }
}
