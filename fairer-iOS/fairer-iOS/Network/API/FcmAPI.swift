//
//  FcmAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class FcmAPI {

    private let fcmProvider = MoyaProvider<FCMRouter>(plugins: [MoyaLoggerPlugin()])
    
    func saveToken(token: String,
                           completion: @escaping (NetworkResult<Any>) -> Void) {
        fcmProvider.request(.saveToken(token: token)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
        
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200..<300:
            guard let decodedData = try? decoder.decode(FCMTokenResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
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
}
