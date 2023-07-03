//
//  AlarmAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class AlarmAPI {
    
    private var alarmProvider = MoyaProvider<AlarmRouter>(session: Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getAlarmStatus
        case putAlarmStatus
    }
    
    func getAlarmStatus(completion: @escaping (NetworkResult<Any>) -> Void) {
        alarmProvider.request(.getAlarmStatus) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .getAlarmStatus)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func putAlarmStatus(body: AlarmRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        alarmProvider.request(.putAlarmStatus(body: body)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .putAlarmStatus)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, response: HTTPURLResponse?, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch statusCode {
        case 200..<300:
            if let authorization = response?.allHeaderFields["Authorization"] as? String,
               let token = authorization.split(separator: " ").last {
                UserDefaultHandler.accessToken = String(token)
            }
            switch responseData {
            case .getAlarmStatus, .putAlarmStatus:
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
        case .getAlarmStatus, .putAlarmStatus:
            guard let decodedData = try? decoder.decode(AlarmResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
