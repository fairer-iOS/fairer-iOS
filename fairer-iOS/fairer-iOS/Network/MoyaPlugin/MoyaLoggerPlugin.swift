//
//  MoyaLoggerPlugin.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation
import UIKit

import Moya

final class MoyaLoggerPlugin: PluginType {

    // MARK: - Request 보낼 시 호출
    func willSend(_ request: RequestType, target: TargetType) {
        guard let httpRequest = request.request else {
            print("--> 유효하지 않은 요청")
            return
        }
        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "unknown method"
        var log = "----------------------------------------------------\n1️⃣[\(method)] \(url)\n----------------------------------------------------\n"
        log.append("2️⃣API: \(target)\n")
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("header: \(headers)\n")
        }
        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        log.append("------------------- END \(method) -------------------")
        print(log)
    }

    // MARK: - Response 받을 시 호출
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            self.onSucceed(response)
        case let .failure(error):
            self.onFail(error)
        }
    }

    func onSucceed(_ response: Response) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        var log = "------------------- 네트워크 통신 성공했는가? -------------------"
        log.append("\n3️⃣[\(statusCode)] \(url)\n----------------------------------------------------\n")
        log.append("response: \n")
        if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
            log.append("4️⃣\(reString)\n")
        }
        log.append("------------------- END HTTP -------------------")
        print(log)
    }

    func onFail(_ error: MoyaError) {
        if let response = error.response {
            onSucceed(response)
            return
        }
        var log = "네트워크 오류"
        log.append("<-- \(error.errorCode)\n")
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP")
        print(log)
    }
}
