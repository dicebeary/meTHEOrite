//
//  LocationManager.swift
//  CoreTests
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import RxSwift
import RxCocoa
import CoreLocation
import Domain

final class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    var userLocation: Observable<CLLocation?> { userLocationSubject.asObservable() }
    
    private let userLocationSubject = BehaviorRelay<CLLocation?>(value: nil)
    private let locationManager = CLLocationManager()
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startLocation() {
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocationSubject.accept(manager.location)
    }
}
