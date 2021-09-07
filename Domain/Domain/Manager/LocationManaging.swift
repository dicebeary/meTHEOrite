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
    var userLocation: Observable<CLLocation?> { get }
    
    func requestPermission()
    
    func startLocation()
    func stopLocation()
}
