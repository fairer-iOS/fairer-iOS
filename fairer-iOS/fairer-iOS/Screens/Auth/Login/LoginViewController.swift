//
//  LoginViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/23.
//

import UIKit

import SnapKit
import GoogleSignIn
import AuthenticationServices

final class LoginViewController: BaseViewController {

    // MARK: - property

    private let signInConfig = GIDConfiguration.init(clientID: "", serverClientID: "")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
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
    
    // MARK: - func
    
    override func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .blue
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
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
                
                guard let idToken = authentication?.idToken else { return }
                UserDefaultHandler.accessToken = idToken
                self.postSignIn(socialType: SocialType.google.rawValue)
            }
        }
    }
    
    private func appleSignIn() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func postSignIn(socialType: String) {
        NetworkService.shared.oauth.postSignIn(socialType: socialType) { [weak self] result in
            switch result {
            case .success(let response):
                guard let data = response as? AuthResponse else { return }
                if let acceesToken = data.accessToken, let refershToken = data.refreshToken {
                    UserDefaultHandler.accessToken = acceesToken
                    UserDefaultHandler.refreshToken = refershToken
                }
                UserDefaultHandler.isLogin = true
                
                guard let isNewMember = data.isNewMember, let hasTeam = data.hasTeam else { return }
                
                if !isNewMember && hasTeam {
                    UserDefaultHandler.hasTeam = true
                    RootHandler.shared.change(root: .Home)
                } else if !isNewMember && !hasTeam {
                    let groupMainViewController = GroupMainViewController()
                    if let userName = data.memberName {
                        groupMainViewController.setUserName(name: userName)
                    }
                    RootHandler.shared.change(root: .groupMain)
                } else if isNewMember && !hasTeam  {
                    let onBoardingNameViewController = OnboardingNameViewController()
                    self?.navigationController?.setViewControllers([onBoardingNameViewController], animated: true)
                }
                self?.saveToken(UserDefaultHandler.fcmToken)
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? UserErrorResponse else { return }
                print(data.errorMessage)
            default:
                print("sign in error")
            }
        }
    }
    
    private func saveToken(_ fcmToken: String) {
        NetworkService.shared.fcm.saveToken(token: fcmToken) { result in
            switch result {
            case .success(_):
                break
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
        let moveToGoogleLogin = UIAction { [weak self] _ in
            self?.googleLogin()
        }
        
        let moveToAppleLogin = UIAction { [weak self] _ in
            self?.appleSignIn()
        }
        
        self.googleButton.addAction(moveToGoogleLogin, for: .touchUpInside)
        self.appleButton.addAction(moveToAppleLogin, for: .touchUpInside)
    }

    private func googleLogin() {
        googleSignIn()
    }
    
    private func appleLogin() {
        appleSignIn()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            switch authorization.credential {
               case let appleIDCredential as ASAuthorizationAppleIDCredential:

                // Create an account in your system.
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                let email = appleIDCredential.email

                if let authorizationCode = appleIDCredential.authorizationCode,
                   let identityToken = appleIDCredential.identityToken,
                   let authString = String(data: authorizationCode, encoding: .utf8),
                   let tokenString = String(data: identityToken, encoding: .utf8) {

                    print("authorizationCode String: \(authString)")
                    print("identityToken String: \(tokenString)")
                    print("\(identityToken)")
                    UserDefaultHandler.accessToken = tokenString
                }
                
                print("User ID : \(userIdentifier)")
                print("User Email : \(email ?? "")")
                print("User Name : \(name)")
                
                self.postSignIn(socialType: "APPLE")
            default:
                break
            }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Error")
    }
}


