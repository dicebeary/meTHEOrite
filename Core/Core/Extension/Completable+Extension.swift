//
//  Completable+Extension.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation
import RxSwift

extension Completable {
    static func complete() -> Completable {
        return Completable.create { completable -> Disposable in
            completable(.completed)
            return Disposables.create()
        }
    }
}
