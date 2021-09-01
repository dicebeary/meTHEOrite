//
//  RxMoya+Extensions.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 07. 18..
//

import Domain
import RxSwift
import Moya
import SwiftSpinner

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    func activateLoadingIndicator() -> Single<Element> {
        return self.do(onSubscribe: {
            SwiftSpinner.show("")
        }, onDispose: {
            SwiftSpinner.hide()
        })

    }

    func parseError() -> Single<Element> {
        return self.catchError { error -> Single<Response> in
            if let moyaError = error as? MoyaError, let data = moyaError.response?.data {
                guard let model = try? JSONDecoder().decode(NewsErrorApiModel.self, from: data) else {
                    return Single<Response>.error(error)
                }

                let mappedError = NewsError.moyaError(code: model.code, message: model.message)
                Single<Response>.error(mappedError)
            }

            return Single<Response>.error(error)
        }
    }
}
