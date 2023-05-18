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
        urlRequest.setValue(UserDefaultHandler.accessToken, forHTTPHeaderField: "Authorization")
        
        print("adapt 적용 \(urlRequest.headers)")
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
        
        changeRefreshToken { isSuccess in
            if isSuccess {
                completion(.retry)
            } else {
                completion(.doNotRetry)
            }
        }
    }
    
    private func changeRefreshToken(completion: @escaping(Bool) -> Void) {
        UserDefaultHandler.accessToken = UserDefaultHandler.refreshToken
        if UserDefaultHandler.accessToken == UserDefaultHandler.refreshToken {
            completion(true)
        } else {
            completion(false)
        }
    }
}



