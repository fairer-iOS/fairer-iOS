//
//  MembersRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Moya

enum MemberRouter {
    case getmemberInfo

}

extension MemberRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getmemberInfo:
            return URLConstant.members + "/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getmemberInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getmemberInfo:
            return .requestPlain
        }
    }
}
