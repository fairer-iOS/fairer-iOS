//
//  UserDefaultHandler.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/16.
//

import Foundation

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
    
    @UserDefault(key: "socialType", defaultValue: "")
    static var socialType: String
}
