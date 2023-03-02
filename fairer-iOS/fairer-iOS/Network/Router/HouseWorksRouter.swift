//
//  HouseWorkRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum HouseWorkRouter {
    case postAddHouseWorks(body: HouseWorksRequest)
}

extension HouseWorkRouter: BaseTargetType {
    var path: String {
        switch self {
        case .postAddHouseWorks(_):
            return URLConstant.houseWorks
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postAddHouseWorks(_):
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postAddHouseWorks(let body):
            return .requestJSONEncodable(body)
        }
    }
}
