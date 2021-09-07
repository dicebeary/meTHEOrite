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
    private var userPin: MKAnnotation?

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
        
        output.userLocation
            .drive(onNext: { [weak self] location in
                if let userPin = self?.userPin {
                    self?.mapView.removeAnnotation(userPin)
                }
                
                let userPin = MKPointAnnotation()
                self?.userPin = userPin
                
                userPin.coordinate = CLLocationCoordinate2D(latitude: 47.497913,
                                                            longitude: 19.040236)
                let region = MKCoordinateRegion(center: userPin.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
                self?.mapView.setRegion(region, animated: true)
                self?.mapView.addAnnotation(userPin)
            })
            .disposed(by: bag)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        
        switch annotation {
        case _ as MeteoriteAnnotation:
            view.pinTintColor = .orange
        case _ as MKPointAnnotation:
            view.pinTintColor = .blue
        default:
            break
        }
        
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
