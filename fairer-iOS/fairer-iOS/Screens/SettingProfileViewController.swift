//
//  SettingProfileViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class SettingProfileViewController: BaseViewController {
    
    // FIXME: - api 로 profile image 불러오기
    
    private let lastProfileImage = ImageLiterals.profileBlue3
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingProfileTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "프로필을 설정해주세요.", lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private lazy var settingProfileButtonView: ProfileImageButtonView = {
        let profileImageButtonView = ProfileImageButtonView()
        profileImageButtonView.image = lastProfileImage
        let action = UIAction { [weak self] _ in
            self?.pushSettingProfileImageViewController()
        }
        profileImageButtonView.addAction(action, for: .touchUpInside)
        return profileImageButtonView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(settingProfileTitleLabel)
        settingProfileTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileButtonView)
        settingProfileButtonView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalTo(settingProfileTitleLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func pushSettingProfileImageViewController() {
        print("누름")
    }
}
