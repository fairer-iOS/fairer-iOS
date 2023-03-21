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
    case postAddTeam(teamName: String)
}

extension TeamsRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getTeamInfo:
            return URLConstant.teams + "/my"
        case .postAddTeam:
            return URLConstant.teams
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTeamInfo:
            return .get
        case .postAddTeam:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getTeamInfo:
            return .requestPlain
        case .postAddTeam(let teamName):
            return .requestParameters(parameters: ["teamName": teamName], encoding: JSONEncoding.default)
        }
    }
}
