//
//  VerySimpleCache.swift
//  Core
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import Foundation

public struct VerySimpleCache {
    private var userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func save<T: Codable>(object: T, forKey: String) {
        guard let data = try? JSONEncoder().encode(object) else {
            debugPrint("Save data problem")
            return
        }
        userDefaults.set(data, forKey: forKey)
    }
    
    func load<T: Codable>(type: T.Type, forKey: String) -> T? {
        guard let data = userDefaults.data(forKey: forKey) else {
            return nil
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            debugPrint("Load data problem")
            return nil
        }
        
        return object
    }
}
