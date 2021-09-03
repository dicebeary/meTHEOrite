//
//  MapViewController.swift
//  Fortnightly
//
//  Created by Vajda Kristóf on 2021. 07. 17..
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

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
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
}

// MARK: - Binding data
extension MapViewController: ViewDataBinder {
    struct Data {
        let imageUrl: Driver<URL?>
        let language: Driver<String?>
        let category: Driver<String?>
        let title: Driver<String>
        let content: Driver<String>
    }

    func bind(data: Data) {
//        data.imageUrl
//            .drive(onNext: { [weak self] url in
//                self?.highlightImageView.kf.setImage(with: url)
//            })
//            .disposed(by: bag)
//
//        data.language
//            .drive(languageLabel.rx.text)
//            .disposed(by: bag)
//
//        data.category
//            .drive(categoryLabel.rx.text)
//            .disposed(by: bag)
//
//        Driver.zip(data.language, data.category)
//            .map { $0.0 == nil || $0.1 == nil }
//            .drive(separatorSymbolLabel.rx.isHidden)
//            .disposed(by: bag)
//
//        data.title
//            .drive(titleLabel.rx.text)
//            .disposed(by: bag)
//
//        data.content
//            .drive(contentLabel.rx.text)
//            .disposed(by: bag)
    }
}

// MARK: - Setup Layout
private extension MapViewController {
    func setupBindings() {
        let output = viewModel.map(from: .init())
        self.bind(data: output.screenData)
    }

    func setupLocalization() {
//        shareButton.setTitle(Localization.newsDetailsShareButton, for: .normal)
//        fullArticleButton.setTitle(Localization.newsDetailsFullArticleButton, for: .normal)
//        separatorSymbolLabel.text =  Localization.newsDetailsSeparator
    }

    func setupStyle() {
//        languageLabel.textColor = UIColor.blackishColor
//        separatorSymbolLabel.textColor = UIColor.blackishColor
//        categoryLabel.textColor = UIColor.blackishColor
//        titleLabel.textColor = UIColor.blackishColor
//        contentLabel.textColor = UIColor.blackishColor
//
//        languageLabel.font = FontFamily.LibreFranklin.bold.font(size: 14.0)
//        separatorSymbolLabel.font = FontFamily.LibreFranklin.bold.font(size: 14.0)
//        categoryLabel.font = FontFamily.LibreFranklin.bold.font(size: 14.0)
//        titleLabel.font = FontFamily.Merriweather.black.font(size: 24.0)
//        contentLabel.font = FontFamily.LibreFranklin.regular.font(size: 18.0)
//
//        fullArticleButton.backgroundColor = UIColor.purpleColor
//        fullArticleButton.titleLabel?.font = FontFamily.LibreFranklin.bold.font(size: 15.0)
//        fullArticleButton.tintColor = UIColor.white
//
//        shareButton.titleLabel?.font = FontFamily.LibreFranklin.bold.font(size: 15.0)
//        shareButton.tintColor = UIColor.purpleColor
    }

    func setupNavigationBar() {
        let imageView = UIImageView(image: Asset.icon.image)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView

        navigationController?.navigationBar.backIndicatorImage = Asset.baselineArrowBackBlack24pt.image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = Asset.baselineArrowBackBlack24pt.image
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.blackishColor
        self.navigationController?.navigationBar.backgroundColor = .white
    }
}
