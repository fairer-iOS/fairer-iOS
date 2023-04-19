//
//  Interceptor.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/16.
//

import Foundation

import Alamofire
import Moya

final class Interceptor: RequestInterceptor {
    
    private let limit = 2
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue(UserDefaultHandler.shared.acceesToken, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse else {
            completion(.doNotRetryWithError(error))
            return
        }
        let statusCode = response.statusCode
        guard request.retryCount < limit, statusCode == 401 else {
            completion(.doNotRetry)
            return
        }
        
        NetworkService.shared.oauth.postSignIn(socialType: UserDefaultHandler.shared.socialType) { result in
            switch result {
            case .success(let data):
                guard let token = data as? AuthResponse else { return }
                guard let accessToken = token.accessToken else { return }
                guard let refreshToken = token.refreshToken else { return }
                UserDefaultHandler.shared.acceesToken = accessToken
                UserDefaultHandler.shared.refershToken = refreshToken
                completion(.retry)
            case .requestErr(let error):
                dump(error)
                UserDefaultHandler.shared.refershToken = ""
                UserDefaultHandler.shared.acceesToken = ""
                RootHandler.shared.change()
            default:
                completion(.doNotRetry)
            }
        }
    }
}



