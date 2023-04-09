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
    case putEditHouseWork(body: EditHouseWorkRequest)
    case deleteHouseWork(body: DeleteHouseWorkRequest)
}

extension HouseWorksRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getHouseWorksByDate:
            return URLConstant.houseWorks + "/list/query"
        case .postAddHouseWorks(_):
            return URLConstant.houseWorks
        case .putEditHouseWork(_):
            return URLConstant.houseWorks + "/v2"
        case .deleteHouseWork(_):
            return URLConstant.houseWorks + "/v2"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHouseWorksByDate:
            return .get
        case .postAddHouseWorks(_):
            return .post
        case .putEditHouseWork(_):
            return .put
        case .deleteHouseWork(_):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHouseWorksByDate(let fromDate,let toDate):
            return .requestParameters(parameters: ["fromDate": fromDate, "toDate": toDate], encoding: URLEncoding.queryString)
        case .postAddHouseWorks(let body):
            return .requestJSONEncodable(body)
        case .putEditHouseWork(let body):
            return .requestJSONEncodable(body)
        case .deleteHouseWork(let body):
            return .requestJSONEncodable(body)
        }
    }
}
