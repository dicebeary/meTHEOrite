//
//  UserInteractorInterface.swift
//  Domain
//
//  Created by Vajda Kristóf on 2021. 09. 07..
//

import RxSwift

// sourcery: AutoMockable
public protocol UserInteractorInterface {
    /// Current location of user
    var userLocation: Observable<Location?> { get }
}
