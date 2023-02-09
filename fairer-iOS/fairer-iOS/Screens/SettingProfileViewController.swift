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
    private let lastName = "진저"
    private let lastStatus: String? = nil
    
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
    private let settingProfileNameLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "이름", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var settingProfileNameTextField: TextField = {
        let textField = TextField()
        textField.text = lastName
        textField.myFont = UIFont.body1
        return textField
    }()
    private let settingProfileStatusLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "상태 메세지", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var settingProfileStatusTextField: TextField = {
        let textField = TextField()
        textField.myFont = UIFont.body1
        textField.text = lastStatus
        return textField
    }()
    private lazy var settingProfileDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = false
        button.title = "입력 완료"
        let action = UIAction {[weak self] _ in
            self?.touchUpToSaveChange()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
    }
    
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
        
        view.addSubview(settingProfileNameLabel)
        settingProfileNameLabel.snp.makeConstraints {
            $0.top.equalTo(settingProfileButtonView.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileNameTextField)
        settingProfileNameTextField.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileStatusLabel)
        settingProfileStatusLabel.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileStatusTextField)
        settingProfileStatusTextField.snp.makeConstraints {
            $0.top.equalTo(settingProfileStatusLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileDoneButton)
        settingProfileDoneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
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
    
    private func setupDelegation() {
        settingProfileNameTextField.delegate = self
        settingProfileStatusTextField.delegate = self
    }
    
    private func pushSettingProfileImageViewController() {
        // FIXME: - 프로필 이미지 선정 뷰로 이동
        print("프로필 이미지")
    }
    
    private func touchUpToSaveChange() {
        // FIXME: - 서버에 프로필 정보 업데이트
        print("입력 완료")
    }
}

// MARK: - extension

extension SettingProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
}
