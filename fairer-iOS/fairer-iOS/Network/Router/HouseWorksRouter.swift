//
//  HouseWorkRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum HouseWorkRouter {
    case postAddHouseWorks
}

extension HouseWorkRouter: BaseTargetType {
    var path: String {
        switch self {
        case .postAddHouseWorks:
            return URLConstant.houseWorks
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAddHouseWorks:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postAddHouseWorks:
            return .requestJSONEncodable
        }
    }
}
