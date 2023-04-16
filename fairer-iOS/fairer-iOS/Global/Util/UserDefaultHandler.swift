//
//  UserDefaultHandler.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/16.
//

import Foundation

class UserDefaultHandler {
    static var shared = UserDefaultHandler()
    
    @UserDefault(key: "accessToken", defaultValue: "")
    var acceesToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    var refershToken: String
    
    func removeAll() {
        _acceesToken.reset()
        _refershToken.reset()
    }
    
}
