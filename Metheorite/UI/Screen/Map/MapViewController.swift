//
//  MapViewController.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import RxSwift
import RxCocoa
import RxMKMapView
import Resolver
import MapKit

final class MapViewController: UIViewController {
    @Injected var viewModel: MapViewModel

    @IBOutlet private weak var mapView: MKMapView!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        
        mapView.delegate = self
    }
}

// MARK: - Setup Layout
private extension MapViewController {
    func setupBindings() {
        let output = viewModel.map(from: .init())
        
        output.pins
            .drive(mapView.rx.annotations)
            .disposed(by: bag)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        view.tintColor = .green
        view.canShowCallout = true
        return view
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0.0 }
        
        UIView.animate(
            withDuration: 0.4,
            animations: {
                views.forEach { $0.alpha = 1.0 }
            })
    }
}

// MARK: - Map Annotation and Helpers
class MeteoriteAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?

    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
