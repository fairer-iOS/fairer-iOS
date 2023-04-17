//
//  MembersRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Moya

enum MemberRouter {
    case getmemberInfo
    case petchMemberInfo(body: MemberPatchRequest)
}

extension MemberRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getmemberInfo:
            return URLConstant.members + "/me"
        case .petchMemberInfo:
            return URLConstant.members
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getmemberInfo:
            return .get
        case .petchMemberInfo:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getmemberInfo:
            return .requestPlain
        case .petchMemberInfo(let body):
            return .requestJSONEncodable(body)
        }
    }
}
