//
//  HouseWorkCompleteRouterAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class HouseWorkCompleteRouterAPI {
    private let provider = MoyaProvider<HouseWorksCompleteRouter>(session : Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case deleteCompleteHouseWork
        case addCompleteHouseWork
    }
    
    public func deleteCompleteHouseWork(
        houseWorkCompleteId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.deleteHouseWorkCompleted(houseWorkCompleteId: houseWorkCompleteId)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteCompleteHouseWork)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func completeHouseWork(
        houseWorkId: Int,
        scheduledDate: String,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.houseWorkCompleted(houseWorkId: houseWorkId, scheduledDate: scheduledDate)) { result in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .addCompleteHouseWork)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        print("statusCode: ", statusCode)
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .deleteCompleteHouseWork, .addCompleteHouseWork:
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
        case .deleteCompleteHouseWork:
            return .success(AnyObject.self)
        case .addCompleteHouseWork:
            guard let decodedData = try? decoder.decode(HouseWorkCompleteResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
