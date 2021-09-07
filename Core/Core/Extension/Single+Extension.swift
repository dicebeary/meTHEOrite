//
//  Single+Extension.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import RxSwift

extension PrimitiveSequence where Trait == SingleTrait, Element: Codable {
    func cacheResponse(to store: Cacheable, as key: String) -> Single<Element> {
        return self.do(onSuccess: { object in
            store.save(object: object, forKey: key)
            debugPrint(type(of: object), "has been cached successful")
        }, onError: { error in
            debugPrint("Storing object to cache failed due to: ", error)
        })
    }
    
    func restoreResponseIfError(from store: Cacheable, as key: String) -> Single<Element> {
        return self.catchError { error in
            guard let element = store.load(type: Element.self, forKey: key) else {
                debugPrint("Retrieving object from cache failed due to parsing error")
                debugPrint("Error: ~~~", error.localizedDescription, "~~~ has passed towards")
                return .error(error)
            }
            
            return Single<Element>.just(element)
        }
    }
}
