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
}

extension OauthRouter: BaseTargetType {
    var path: String {
        switch self {
        case .oauthLogin:
            return URLConstant.oauth + "/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauthLogin:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oauthLogin(let clientType, let socialType):
            return .requestParameters(parameters: [
                "clientType": clientType,
                "socialType": socialType
            ], encoding: JSONEncoding.default)
        }
    }
}
