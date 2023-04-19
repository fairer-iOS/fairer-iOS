//
//  OauthRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum OauthRouter {
    case oauthLogin(socialType: AuthRequest)
    case logout(Authorization: String)
}

extension OauthRouter: BaseTargetType {
    var path: String {
        switch self {
        case .oauthLogin:
            return URLConstant.oauth + "/login"
        case .logout:
            return URLConstant.oauth + "/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .oauthLogin, .logout:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .oauthLogin(let socialType):
            return .requestJSONEncodable(socialType)
        case .logout(let Authorization):
            return .requestParameters(parameters: ["Authorization": Authorization], encoding: JSONEncoding.default)
        }
    }
}
