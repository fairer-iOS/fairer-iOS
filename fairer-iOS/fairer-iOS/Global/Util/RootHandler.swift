//
//  RootHandler.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/18.
//

import UIKit

final class RootHandler {
    static let shared = RootHandler()
    
    enum Root {
        case login
        case Home
    }
    
    func changeLogin(root: Root) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        switch root {
        case .login:
            let loginViewController = LoginViewController()
            // MARK: - 로그인 뷰로 이동
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
            
        case .Home:
            let homeViewController = HomeViewController()
            // MARK: - Home 뷰로 이동
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: homeViewController)
        }
    }
}
