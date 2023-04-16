//
//  UserDefault.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/16.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
