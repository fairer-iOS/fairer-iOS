//
//  LoginViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/23.
//

import UIKit

import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - property
    
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgLogoLogin
        return imageView
    }()
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
        config.image = ImageLiterals.googleLogo
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
        config.image = ImageLiterals.appleLogo
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
    
    override func configUI() {
        view.backgroundColor = .blue
    }
    
    override func render() {
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(239)
        }
        
        view.addSubview(loginLabel)
        loginLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImage.snp.bottom).offset(30)
        }
        
        view.addSubview(appleButton)
        appleButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
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
}
