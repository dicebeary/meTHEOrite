//
//  UserInteractor.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import Domain
import CoreLocation
import Resolver
import RxSwift

final class UserInteractor: UserInteractorInterface {
    @Injected var locationManager: LocationManaging
    
    var userLocation: Observable<Location?> {
        locationManager.userLocation
            .map { clLocation in
                guard let longitude = clLocation?.coordinate.longitude,
                      let latitude = clLocation?.coordinate.latitude else {
                     return nil
                }
                
                return Location(longitude: longitude, latitude: latitude)
            }
    }
}
