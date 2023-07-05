//
//  NetworkService.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/24.
//

final class NetworkService {
    static let shared = NetworkService()

    private init() { }
    
//    let alarm = AlarmAPI()

    let fcm = FcmAPI()

    let houseWorkCompleteRouter = HouseWorkCompleteRouterAPI()
    
    let houseWorks = HouseWorksAPI()
    
    let members = MembersAPI()

    let oauth = OauthAPI()

//    let presets = PresetsAPI()

    let rules = RulesAPI()
    
    let teams = TeamsAPI()
}
