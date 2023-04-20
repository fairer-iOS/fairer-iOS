//
//  BaseTargetType.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {

    var baseURL: URL {
        return URL(string: BaseURLConstant.base)!
    }

    var headers: [String: String]? {
        let header = [
            "Content-Type": "application/json",
            "Authorization": UserDefaultHandler.shared.acceesToken
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
