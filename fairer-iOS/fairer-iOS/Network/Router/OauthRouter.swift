//
//  OauthRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum OauthRouter {
    case oauthLogin(socialType: String)
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
        case .oauthLogin(let socialType):
            return .requestJSONEncodable(socialType)
        }
    }
}
