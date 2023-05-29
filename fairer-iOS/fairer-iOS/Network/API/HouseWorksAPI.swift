//
//  HouseWorksAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class HouseWorksAPI {
    
    private let provider = MoyaProvider<HouseWorksRouter>(session : Moya.Session(interceptor: Interceptor()), plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getHouseWorksByDate
        case postAddHouseWorks
        case getMemberHouseWorksByDate
        case putEditHouseWork
        case deleteHouseWork
        case getHouseWorkById
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
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .getHouseWorksByDate)
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
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .postAddHouseWorks)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getMemberHouseWorksByDate(
        fromDate: String,
        toDate: String,
        teamMemberId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void
    ) {
        provider.request(.getMemberHouseWorksByDate(fromDate: fromDate, toDate: toDate, teamMemberId: teamMemberId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .getMemberHouseWorksByDate)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }

    func putEditHouseWork(body: EditHouseWorkRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.putEditHouseWork(body: body)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .putEditHouseWork)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func deleteHouseWork(body: DeleteHouseWorkRequest, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.deleteHouseWork(body: body)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .deleteHouseWork)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getHouseWorkById(houseWorkId: Int, completion: (NetworkResult<Any>) -> Void) {
        provider.request(.getHouseWorkById(houseWorkId: houseWorkId)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let httpUrlResponse = response.response
                let networkResult = self.judgeStatus(by: statusCode, data, response: httpUrlResponse, responseData: .getHouseWorkById)
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
            case .getHouseWorksByDate, .postAddHouseWorks, .getMemberHouseWorksByDate, .getHouseWorkById, .putEditHouseWork, .deleteHouseWork:
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
        case .getMemberHouseWorksByDate:
            guard let decodedData = try? decoder.decode(WorkInfoReponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .putEditHouseWork:
            guard let decodedData = try? decoder.decode(EditHouseWorkResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .deleteHouseWork:
            return .success(BlankResponse())
        case .getHouseWorkById:
            guard let decodedData = try? decoder.decode(HouseWorkResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
