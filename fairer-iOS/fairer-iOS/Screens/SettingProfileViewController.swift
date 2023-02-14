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
    private let settingProfileNameWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트는 5글자를 초과하여 입력하실 수 없어요."
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private let settingProfileNameSpecialWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "&,!,#,@,^와 같은 특수문자는 입력하실 수 없어요."
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var settingProfileNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingProfileNameLabel, settingProfileNameTextField, settingProfileNameWarningLabel, settingProfileNameSpecialWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
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
    private let settingProfileStatusWarningLabel: UILabel = {
        let label = UILabel()
        label.text = "텍스트는 20글자를 초과하여 입력하실 수 없어요."
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var settingProfileStatusStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingProfileStatusLabel, settingProfileStatusTextField, settingProfileStatusWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
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
        setupNotificationCenter()
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
        
        view.addSubview(settingProfileNameStackView)
        settingProfileNameStackView.snp.makeConstraints {
            $0.top.equalTo(settingProfileButtonView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(settingProfileStatusStackView)
        settingProfileStatusStackView.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameStackView.snp.bottom).offset(8)
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
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func pushSettingProfileImageViewController() {
        // FIXME: - 프로필 이미지 선정 뷰로 이동
        print("프로필 이미지")
    }
    
    private func touchUpToSaveChange() {
        // FIXME: - 서버에 프로필 정보 업데이트
        print("입력 완료")
    }
    
    private func didTappedTextField() {
        settingProfileTitleLabel.isHidden = true
        settingProfileButtonView.snp.updateConstraints {
            $0.top.equalTo(settingProfileTitleLabel.snp.bottom).offset(-65)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func didTappedBackground() {
        settingProfileTitleLabel.isHidden = false
        settingProfileButtonView.snp.updateConstraints {
            $0.top.equalTo(settingProfileTitleLabel.snp.bottom).offset(26)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func checkMaxLength(textField: UITextField) {
        let maxLength = textField == settingProfileNameTextField ? 5 : 20
        let warningLabel = textField == settingProfileNameTextField ? settingProfileNameWarningLabel : settingProfileStatusWarningLabel
        
        if let text = textField.text {
            if text.count > maxLength {
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.negative20.cgColor
                warningLabel.isHidden = false
            } else {
                textField.layer.borderWidth = 0
                warningLabel.isHidden = true
            }
        }
    }
    
    private func checkSpecialCharacter(textField: UITextField) {
        if let text = textField.text, textField == settingProfileNameTextField {
            if text.hasSpecialCharacters() {
                settingProfileNameSpecialWarningLabel.isHidden = false
            } else {
                settingProfileNameSpecialWarningLabel.isHidden = true
            }
        }
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.settingProfileDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 36)
            })
        }
        
        didTappedTextField()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.settingProfileDoneButton.transform = .identity
        })
        
        didTappedBackground()
    }
}

// MARK: - extension

extension SettingProfileViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength(textField: textField)
        checkSpecialCharacter(textField: textField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
