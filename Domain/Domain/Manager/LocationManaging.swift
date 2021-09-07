//
//  LocationManaging.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import CoreLocation
import RxSwift

// sourcery: AutoMockable
public protocol LocationManaging {
    /// Current location of user
    var userLocation: Observable<CLLocation?> { get }
    
    /// Gather permission for getting user location
    func requestPermission()
    
    /// Start updating location
    func startLocation()
    /// Stop updating location
    func stopLocation()
}
