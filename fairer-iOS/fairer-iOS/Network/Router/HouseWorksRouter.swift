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
    case getMemberHouseWorksByDate(fromDate: String, toDate: String, teamMemberId: Int)
    case putEditHouseWork(body: EditHouseWorkRequest)
    case deleteHouseWork(body: DeleteHouseWorkRequest)
    case getHouseWorkById(houseWorkId: Int)
}

extension HouseWorksRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getHouseWorksByDate:
            return URLConstant.houseWorks + "/list/query"
        case .postAddHouseWorks(_):
            return URLConstant.houseWorks
        case .getMemberHouseWorksByDate(_, _, let teamMemberId):
            return URLConstant.houseWorks + "/list/member/\(teamMemberId)/query"
        case .putEditHouseWork(_):
            return URLConstant.houseWorks + "/v2"
        case .deleteHouseWork(_):
            return URLConstant.houseWorks + "/v2"
        case .getHouseWorkById(let houseWorkId):
            return URLConstant.houseWorks + "/\(houseWorkId)/detail"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHouseWorksByDate, .getMemberHouseWorksByDate:
            return .get
        case .postAddHouseWorks(_):
            return .post
        case .putEditHouseWork(_):
            return .put
        case .deleteHouseWork(_):
            return .delete
        case .getHouseWorkById(_):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHouseWorksByDate(let fromDate,let toDate):
            return .requestParameters(parameters: ["fromDate": fromDate, "toDate": toDate], encoding: URLEncoding.queryString)
        case .postAddHouseWorks(let body):
            return .requestJSONEncodable(body)
        case .getMemberHouseWorksByDate(let fromDate, let toDate, _):
            return .requestParameters(parameters: ["fromDate": fromDate, "toDate": toDate], encoding: URLEncoding.queryString)
        case .putEditHouseWork(let body):
            return .requestJSONEncodable(body)
        case .deleteHouseWork(let body):
            return .requestJSONEncodable(body)
        case .getHouseWorkById(_):
            return .requestPlain
        }
    }
}
