//
//  TeamsAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class TeamsAPI {
    
    private var teamsProvider = MoyaProvider<TeamsRouter>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getTeamInfo
    }
    
    func getTeamInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.getTeamInfo) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getTeamInfo)
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
            case .getTeamInfo:
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
        case .getTeamInfo:
            guard let decodedData = try? decoder.decode(TeamInfoResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
