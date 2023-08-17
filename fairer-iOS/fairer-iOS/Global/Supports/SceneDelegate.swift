//
//  SceneDelegate.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/08/21.
//

import UIKit

import GoogleSignIn

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var errorWindow: UIWindow?
    private var networkMonitor: NetworkMonitor = NetworkMonitor()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        startMonitoringNetwork(on: scene)
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
                
        if UserDefaultHandler.isLogin && UserDefaultHandler.hasTeam {
            RootHandler.shared.change(root: .Home)
        } else if UserDefaultHandler.isLogin && !UserDefaultHandler.hasTeam {
            RootHandler.shared.change(root: .groupMain)
        } else if !UserDefaultHandler.isLogin {
            RootHandler.shared.change(root: .login)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            GIDSignIn.sharedInstance.handle(url)
            UserDefaultHandler.hasTeam ? navigateToAlreadyInGroup() : navigateToEnterHouse(url)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        networkMonitor.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

extension SceneDelegate {
    private func startMonitoringNetwork(on scene: UIScene) {
        networkMonitor.startMonitoring(statusUpdateHandler: { [weak self] connectionStatus in
            switch connectionStatus {
            case .satisfied: self?.removeNetworkErrorWindow()
            case .unsatisfied: self?.loadNetworkErrorWindow(on: scene)
            default: break
            }
        })
    }
    
    private func removeNetworkErrorWindow() {
        DispatchQueue.main.async { [weak self] in
            self?.errorWindow?.resignKey()
            self?.errorWindow?.isHidden = true
            self?.errorWindow = nil
        }
    }
    
    private func loadNetworkErrorWindow(on scene: UIScene) {
        if let windowScene = scene as? UIWindowScene {
            DispatchQueue.main.async { [weak self] in
                let window = UIWindow(windowScene: windowScene)
                window.windowLevel = .statusBar
                window.makeKeyAndVisible()
                let noNetworkView = NoNetworkView(frame: window.bounds)
                window.addSubview(noNetworkView)
                self?.errorWindow = window
            }
        }
    }
    
    private func navigateToEnterHouse(_ url: URL) {
        if url.absoluteString.contains("example.com") {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
            let enterHouseViewController = EnterHouseViewController()
            sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: enterHouseViewController)
            
            let inviteCode = url.absoluteString.components(separatedBy: "example.com/")[1].components(separatedBy: "/?link")[0]
            enterHouseViewController.enterHouseCodeTextfield.text = inviteCode
            enterHouseViewController.enterHouseDoneButton.isDisabled = false
            
            enterHouseViewController.backButton.isHidden = true
            enterHouseViewController.navigationItem.hidesBackButton = true
            enterHouseViewController.navigationController?.setViewControllers([enterHouseViewController], animated: true)
        }
    }
    
    private func navigateToAlreadyInGroup() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let alreadyInGroupViewController = AlreadyInGroupViewController()
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: alreadyInGroupViewController)
        alreadyInGroupViewController.navigationController?.setViewControllers([alreadyInGroupViewController], animated: true)
    }
}
