//
//  RulesROuter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Moya

enum RulesRouter {
    case getRules
    case postRuels(ruleName: String)
    case deleteRules(ruleId: Int)
}

extension RulesRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getRules, .postRuels:
            return URLConstant.rules
        case .deleteRules(let ruleId):
            return URLConstant.rules + "/\(ruleId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRules:
            return .get
        case .postRuels:
            return .post
        case .deleteRules:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getRules, .deleteRules:
            return .requestPlain
        case .postRuels(let ruleName):
            return .requestParameters(parameters: [
                "ruleName": ruleName
            ], encoding: JSONEncoding.default)
        }
    }
}
