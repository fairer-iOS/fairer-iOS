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
    
    func getRules(completion: @escaping (NetworkResult<Any>) -> Void ) {
        rulesProvider.request(.getRules) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getRules)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postRules(ruleName: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        rulesProvider.request(.postRuels(ruleName: ruleName)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getRules)
                completion(networkResult)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getRules, .postRules, .deleteRules:
                return isValidData(data: data, responseData: responseData)
            }
        case 400:
            guard let decodedData = try? decoder.decode(ServerErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 401..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch responseData {
        case .getRules, .postRules:
            guard let decodedData = try? decoder.decode(RulesResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)

        case .deleteRules:
            guard let decodedData = try? decoder.decode(RulesResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}


