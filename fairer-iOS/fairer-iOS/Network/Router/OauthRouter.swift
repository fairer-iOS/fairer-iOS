//
//  OauthRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum OauthRouter {
    case oauthLogin(clientType: String, socialType: String)
    case getToken(clientType: String, socialType: String)
    case signout
}

extension OauthRouter: BaseTargetType {
    var path: String {
        switch self {
        case .oauthLogin, .getToken:
            return URLConstant.oauth + "/login"
        case .signout:
            return URLConstant.oauth + "/signout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauthLogin, .getToken, .signout:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oauthLogin(let clientType, let socialType), .getToken(let clientType, let socialType):
            return .requestParameters(parameters: [
                "clientType": clientType,
                "socialType": socialType
            ], encoding: JSONEncoding.default)
        case .signout:
            return .requestPlain
        }
    }
}
