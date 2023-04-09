//
//  HouseWorksAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class HouseWorksAPI {
    
    private let provider = MoyaProvider<HouseWorksRouter>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getHouseWorksByDate
        case postAddHouseWorks
    }
    
    public func getHouseWorksByDate(
        fromDate: String,
        toDate: String,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.getHouseWorksByDate(fromDate: fromDate, toDate: toDate)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getHouseWorksByDate)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postAddHouseWorksAPI(body: [HouseWorksRequest], completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.postAddHouseWorks(body: body)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postAddHouseWorks)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getHouseWorksByDate:
                return isValidData(data: data, responseData: responseData)
            case .postAddHouseWorks:
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
        case .getHouseWorksByDate:
            guard let decodedData = try? decoder.decode(WorkInfoReponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postAddHouseWorks:
            guard let decodedData = try? decoder.decode(HouseWorksResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
