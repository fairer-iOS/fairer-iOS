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
    
    init() { }
    
    private(set) var getTeamInfoData: TeamInfoResponse?
    
    func getTeamInfo(completion: @escaping (TeamInfoResponse?) -> Void) {
        self.teamsProvider.request(.getTeamInfo) { [self] result in
            switch result {
            case .success(let response):
                do {
                    self.getTeamInfoData = try response.map(TeamInfoResponse?.self)
                    completion(getTeamInfoData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
