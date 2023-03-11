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
            "Authorization": "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSRUZSRVNIIiwiYXVkIjoiMTEiLCJpYXQiOjE2NjA1Njg0OTEsImV4cCI6MTc2MDU2ODQ5MX0.Fj-C2DXrQFgEdaD1umMo9FZ05Mfc0NXLUfrpIuORhpp7NWPJ_2o9we33-UJ5TcpcygqyzokwAl1iEstMxD5Nvw"
        ]
        return header
    }

    var sampleData: Data {
        return Data()
    }

}
