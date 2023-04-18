//
//  UserDefaultHandler.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/16.
//

import Foundation

struct UserDefaultHandler {
    static var shared = UserDefaultHandler()
    
    @UserDefault(key: "accessToken", defaultValue: "")
    var acceesToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    var refershToken: String
    
    @UserDefault(key: "socialType", defaultValue: SocialType.google)
    var socialType: SocialType
    
    func clearUserInformations() {
        _acceesToken.removeAll()
        _refershToken.removeAll()
        _socialType.removeAll()
    }
}

