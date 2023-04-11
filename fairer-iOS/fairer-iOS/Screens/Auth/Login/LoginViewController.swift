//
//  LoginViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/23.
//

import UIKit

import SnapKit
import GoogleSignIn

final class LoginViewController: BaseViewController {

    // MARK: - property

    private let signInConfig = GIDConfiguration.init(clientID: "", serverClientID: "")
    private let OauthRequestData = AuthRequest()
    private let logoImage = UIImageView(image: ImageLiterals.imgLogoLogin)
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .h3
        label.textColor = .white
        label.setTextWithLineHeight(text: "평화로운 집안일,\n페어러가 도와드릴게요", lineHeight: 28)
        label.textAlignment = .center
        return label
    }()
    private let googleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgGoogleLogo
        config.imagePlacement = .leading
        config.baseForegroundColor = .gray800
        var titleAttr = AttributedString.init("구글로 로그인")
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 8
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        return button
    }()
    private let appleButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgAppleLogo
        config.imagePlacement = .leading
        config.baseForegroundColor = .white
        var titleAttr = AttributedString.init("Apple로 로그인")
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 10
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = .black
        return button
    }()
    
    // MARK: - lifecycle

    override func viewWillAppear(_ animated: Bool) {
        self.setButtonAction()
    }
    
    override func configUI() {
        view.backgroundColor = .blue
    }
    
    override func render() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-50)
        }
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(34)
        }
        
        view.addSubview(appleButton)
        appleButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(50)
        }
        
        view.addSubview(googleButton)
        googleButton.snp.makeConstraints {
            $0.bottom.equalTo(appleButton.snp.top).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - helper func
    
    override func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
    }

    private func googleSignIn() {
        GIDSignIn.sharedInstance.signIn(with: self.signInConfig, presenting: self) { signInResult, error in
            guard error == nil else { return }
            guard let signInResult = signInResult else { return }
            
            signInResult.authentication.do { [self] authentication, error in
                guard error == nil else {
                    print(error as Any)
                    return
                }
                guard let authentication = authentication else { return }
                let idToken = authentication.idToken
                UserDefaults.standard.set(idToken, forKey: "OauthIdToken")
                self.postSignIn()
            }
        }
    }
    
    func postSignIn() {
        NetworkService.shared.oauth.postSignIn(socialType: OauthRequestData) { result in
            switch result {
            case .success(let response):
                guard let data = response as? AuthResponse else { return }
                print(data)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? UserErrorResponse else { return }
                print(data.errorMessage)
            default:
                print("sign in error")
            }
        }
    }
}

// MARK: - navigation control

extension LoginViewController {
    
    private func setButtonAction() {
        let moveToOnboardingView = UIAction { [weak self] _ in
            self?.moveToOnboardingView()
        }
        
        // MARK: - fix me : 토큰 처리할 때 moveToGoogleLogin, appleLogin 으로 연결
        self.googleButton.addAction(moveToOnboardingView, for: .touchUpInside)
        self.appleButton.addAction(moveToOnboardingView, for: .touchUpInside)
    }
    
    private func moveToOnboardingView() {
        let onBoardingViewController = OnboardingNameViewController()
        self.navigationController?.pushViewController(onBoardingViewController, animated: true)
    }
}
