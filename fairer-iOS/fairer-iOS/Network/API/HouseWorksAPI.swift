//
//  HouseWorksAPI.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation

import Moya

final class HouseWorksAPI {
    
    private var houseWorksProvider = MoyaProvider<HouseWorkRouter>(plugins: [MoyaLoggerPlugin()])
    
    init() { }
    
    private(set) var postAddHouseWorksData: [HouseWorksResponse]?
    
    func postAddHouseWorksAPI(body: [HouseWorksRequest], completion: @escaping ([HouseWorksResponse]?) -> Void) {
        self.houseWorksProvider.request(.postAddHouseWorks(body: body)) { [self] result in
            switch result {
            case .success(let response):
                do {
                    self.postAddHouseWorksData = try response.map([HouseWorksResponse]?.self)
                    completion(postAddHouseWorksData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
