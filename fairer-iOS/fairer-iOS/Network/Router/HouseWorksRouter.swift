//
//  HouseWorkRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum HouseWorksRouter {
    case getHouseWorksByDate(fromDate: String, toDate: String)
    case postAddHouseWorks(body: [HouseWorksRequest])
}

extension HouseWorksRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getHouseWorksByDate:
            return URLConstant.houseWorks + "/list/query"
        case .postAddHouseWorks(_):
            return URLConstant.houseWorks
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHouseWorksByDate:
            return .get
        case .postAddHouseWorks(_):
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHouseWorksByDate(let fromDate,let toDate):
            return .requestParameters(parameters: ["fromDate": fromDate, "toDate": toDate], encoding: URLEncoding.queryString)
        case .postAddHouseWorks(let body):
            return .requestJSONEncodable(body)
        }
    }
}