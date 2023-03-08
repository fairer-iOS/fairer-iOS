//
//  HouseWorkCompleteRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum HouseWorksCompleteRouter {
    case deleteHouseWorkCompleted(houseWorkCompleteId: Int)
    case houseWorkCompleted(houseWorkId: Int, scheduledDate: String)
}

extension HouseWorksCompleteRouter: BaseTargetType {
    var path: String {
        switch self {
        case .deleteHouseWorkCompleted(let houseWorkCompleteId):
            return URLConstant.houseWorksComplete + "/\(houseWorkCompleteId)"
        case .houseWorkCompleted(let houseWorkId, _):
            return URLConstant.houseWorksComplete + "/\(houseWorkId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .deleteHouseWorkCompleted:
            return .delete
        case .houseWorkCompleted:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .deleteHouseWorkCompleted:
            return .requestPlain
        case .houseWorkCompleted(_, let scheduledDate):
            return .requestParameters(parameters: [
                "scheduledDate": scheduledDate
            ], encoding: URLEncoding.queryString)
        }
    }
}
