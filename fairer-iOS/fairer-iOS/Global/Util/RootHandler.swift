//
//  RootHandler.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/18.
//

import UIKit

final class RootHandler {
    static let shared = RootHandler()
    
    func change() {
        let loginViewController = LoginViewController()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        
        // MARK: - 로그인 뷰로 이동
        sceneDelegate.window?.rootViewController = loginViewController
        LoginViewController.navigationController?.setViewControllers([loginViewController], animated: true)
    }
}
