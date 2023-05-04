//
//  MembersAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//
import Foundation

import Moya

final class MembersAPI {
    
    private var membersProvider = MoyaProvider<MemberRouter>(session : Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getMemberInfo
    }
    
    func getMemberInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        membersProvider.request(.getmemberInfo) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .getMemberInfo)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, response: HTTPURLResponse?,  responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200..<300:
            if let authorization = response?.allHeaderFields["Authorization"] as? String,
               let token = authorization.split(separator: " ").last {
                UserDefaultHandler.accessToken = String(token)
                print("현재 적용 헤더 \(UserDefaultHandler.accessToken)")
            }
            switch responseData {
            case .getMemberInfo:
                return isValidData(data: data, responseData: responseData)
            }
        case 400:
            guard let decodedData = try? decoder.decode(UserErrorResponse.self, from: data) else {
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
        case .getMemberInfo:
            guard let decodedData = try? decoder.decode(MemberResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
