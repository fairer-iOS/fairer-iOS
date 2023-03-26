//
//  TeamsRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum TeamsRouter {
    case getTeamInfo
}

extension TeamsRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getTeamInfo:
            return URLConstant.teams + "/my"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTeamInfo:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTeamInfo:
            return .requestPlain
        }
    }
}
