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
        case getInviteCodeInfo
        case postAddTeam
        case postJoinTeam
        case patchTeamInfo
        case postLeaveTeam
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
    
    func getInviteCodeInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.getInviteCodeInfo) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getInviteCodeInfo)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postAddTeam(teamName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.postAddTeam(teamName: teamName)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postAddTeam)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postJoinTeam(inviteCode: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.postJoinTeam(inviteCode: inviteCode)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postJoinTeam)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func patchTeamInfo(teamName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.patchTeamInfo(teamName: teamName)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .patchTeamInfo)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func postLeaveTeam(completion: @escaping (NetworkResult<Any>) -> Void) {
        teamsProvider.request(.postLeaveTeam) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postLeaveTeam)
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
            case .getTeamInfo, .postAddTeam, .postJoinTeam, .patchTeamInfo, .postLeaveTeam, .getInviteCodeInfo:
                return isValidData(data: data, responseData: responseData)
            }
        case 400:
            guard let decodedData = try? decoder.decode(UserErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 401..<500:
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
        case .getInviteCodeInfo:
            guard let decodedData = try? decoder.decode(InviteCodeInfoResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postAddTeam:
            guard let decodedData = try? decoder.decode(AddTeamResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postJoinTeam, .patchTeamInfo, .postLeaveTeam:
            return .success(())
        }
    }
}
