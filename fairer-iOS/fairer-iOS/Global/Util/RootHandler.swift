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
        case groupMain
    }
    
    func change(root: Root) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        switch root {
        case .login:
            let loginViewController = LoginViewController()
            // MARK: - 로그인 뷰로 이동
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
            loginViewController.navigationController?.setViewControllers([loginViewController], animated: true)
            
        case .Home:
            let homeViewController = HomeViewController()
            // MARK: - Home 뷰로 이동
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: homeViewController)
            homeViewController.navigationController?.setViewControllers([homeViewController], animated: true)
            
        case .groupMain:
            let groupMainViewController = GroupMainViewController()
            // MARK: - 그룹 참여 뷰로 이동
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: groupMainViewController)
            groupMainViewController.navigationController?.setViewControllers([groupMainViewController], animated: true)
        }
    }
}
