//
//  PresetsAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class PresetsAPI {
    
    private var presetsProvider = MoyaProvider<PresetRouter>(plugins: [MoyaLoggerPlugin()])
    
    private enum ResponseData {
        case getAllPreset
        case getHouseWorkPreset
    }
    
    func getAllPreset(completion: @escaping (NetworkResult<Any>) -> Void) {
        presetsProvider.request(.getAllPreset) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getAllPreset)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getHouseWorkPreset(space: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        presetsProvider.request(.getHouseWorkPreset(space: space)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getHouseWorkPreset)
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
            case .getAllPreset, .getHouseWorkPreset:
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
        case .getAllPreset:
            guard let decodedData = try? decoder.decode([GetPresetResponse].self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getHouseWorkPreset:
            guard let decodedData = try? decoder.decode(GetPresetResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
