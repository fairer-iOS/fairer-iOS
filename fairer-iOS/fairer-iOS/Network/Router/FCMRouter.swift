//
//  FCMRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum FCMRouter {
    case saveToken(token: String)
}

extension FCMRouter: BaseTargetType {
    var path: String {
        switch self {
        case .saveToken:
            return URLConstant.fcm + "/token"
        }
    }
        
        var method: Moya.Method {
            switch self {
            case .saveToken:
                return .post
            }
        }
        
        var task: Moya.Task {
            switch self {
            case .saveToken(let token):
                return .requestParameters(parameters: [
                    "token": token
                ], encoding: JSONEncoding.default)
            }
        }
    }
