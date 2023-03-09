//
//  RulesAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class RulesAPI {
    
    private var rulesProvider = MoyaProvider<RulesRouter>(plugins: [MoyaLoggerPlugin()])
    
    init() {}
    
    private enum ResponseData {
        case getRules
        case postRules
        case deleteRules
    }
    
    func getRules(ruleId: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        rulesProvider.request(.getRules) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


