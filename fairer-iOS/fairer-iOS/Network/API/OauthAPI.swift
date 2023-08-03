//
//  OauthAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class OauthAPI {

    private let authProvider = MoyaProvider<OauthRouter>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case postSignIn
        case postLogout
        case postSignout
    }
    
    func postSignIn(socialType: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.oauthLogin(clientType: TextLiteral.clientType, socialType: socialType)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .postSignIn)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postLogout(authorization: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.oauthLogout(authorization: authorization)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .postLogout)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postSignout(completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.signout) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .postSignout)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
        
    private func judgeStatus(by statusCode: Int, _ data: Data, response: HTTPURLResponse?,  responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .postSignIn, .postLogout, .postSignout:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
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
        case .postSignIn:
            guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postLogout, .postSignout:
            return .success(())
        }
    }
}
