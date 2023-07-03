//
//  AlarmRouter.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

enum AlarmRouter {
    case getAlarmStatus
    case putAlarmStatus(body: AlarmRequest)
}

extension AlarmRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getAlarmStatus, .putAlarmStatus:
            return URLConstant.alarm
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAlarmStatus:
            return .get
        case .putAlarmStatus:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getAlarmStatus:
            return .requestPlain
        case .putAlarmStatus(let body):
            return .requestJSONEncodable(body)
        }
    }
}
