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
    }
    
    // MARK: - helper func
    
    override func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
    }
}
