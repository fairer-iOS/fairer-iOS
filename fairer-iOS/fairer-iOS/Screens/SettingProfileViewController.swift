//
//  SettingProfileViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class SettingProfileViewController: BaseViewController {
    
    private var firstName: String?
    private var firstStatus: String?
    
    private var isSettingProfileViewPoped = false
    private var lastProfileImage: String? {
        didSet {
            if let imageString = lastProfileImage {
                settingProfileButtonView.profileImageView.load(from: imageString)
            }
        }
    }
    private var lastName: String? {
        didSet {
            settingProfileNameTextField.text = lastName
        }
    }
    private var lastStatus: String? {
        didSet {
            settingProfileStatusTextField.text = lastStatus
        }
    }
    
    private var isNameSatisfied = true
    private var isStatusSatisfied = true
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingProfileTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingProfileViewControllerTitleLabel, lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private lazy var settingProfileButtonView: ProfileImageButtonView = {
        let profileImageButtonView = ProfileImageButtonView()
        let UIImageView = UIImageView()
        return profileImageButtonView
    }()
    private let settingProfileNameLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingProfileViewControllerProfileNameLabel, lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var settingProfileNameTextField: TextField = {
        let textField = TextField(type: .medium, placeHolder: TextLiteral.settingProfileViewControllerPlaceholderText)
        textField.text = lastName
        return textField
    }()
    private let settingProfileNameWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldWarningOverFive
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private let settingProfileNameSpecialWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldDisableSignLabel
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var settingProfileNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingProfileNameWarningLabel, settingProfileNameSpecialWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        return stackView
    }()
    private let settingProfileStatusLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingProfileViewControllerProfileStatusLabel, lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private lazy var settingProfileStatusTextField: TextField = {
        let textField = TextField(type: .medium, placeHolder: TextLiteral.settingProfileViewControllerPlaceholderText)
        textField.text = lastStatus
        return textField
    }()
    private let settingProfileStatusWarningLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldWarningOverTwenty
        label.textColor = .negative20
        label.font = .body2
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    private lazy var settingProfileDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        button.title = TextLiteral.doneButtonText
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupNotificationCenter()
        setButtomAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isSettingProfileViewPoped == false {
            getMyInfo()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isSettingProfileViewPoped = false
    }
    
    override func render() {
        view.addSubviews(settingProfileTitleLabel, settingProfileButtonView, settingProfileNameLabel, settingProfileNameTextField, settingProfileNameStackView, settingProfileStatusLabel, settingProfileStatusTextField, settingProfileStatusWarningLabel, settingProfileDoneButton)
        
        settingProfileTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.topComponentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileButtonView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.equalTo(settingProfileTitleLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
        
        settingProfileNameLabel.snp.makeConstraints {
            $0.top.equalTo(settingProfileButtonView.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileNameTextField.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileNameStackView.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameTextField.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileStatusLabel.snp.makeConstraints {
            $0.top.equalTo(settingProfileNameStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileStatusTextField.snp.makeConstraints {
            $0.top.equalTo(settingProfileStatusLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingProfileStatusWarningLabel.snp.makeConstraints {
            $0.top.equalTo(settingProfileStatusTextField.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
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
    
    private func didTappedTextField() {
        settingProfileTitleLabel.isHidden = true
        settingProfileButtonView.snp.updateConstraints {
            $0.top.equalTo(settingProfileTitleLabel.snp.bottom).offset(-85)
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
    
    private func checkNameTextField() {
        if let text = settingProfileNameTextField.text {
            if text.count > 5 || text.hasSpecialCharacters() {
                settingProfileNameTextField.layer.borderWidth = 1
                settingProfileNameTextField.layer.borderColor = UIColor.negative20.cgColor
                isNameSatisfied = false
            } else {
                settingProfileNameTextField.layer.borderWidth = 0
                if text.count > 0 {
                    isNameSatisfied = true
                    lastName = text
                } else {
                    isNameSatisfied = false
                }
            }
            
            if text.count > 5 && text.hasSpecialCharacters() {
                settingProfileNameWarningLabel.isHidden = false
                settingProfileNameSpecialWarningLabel.isHidden = false
            } else if text.count > 5 {
                settingProfileNameWarningLabel.isHidden = false
                settingProfileNameSpecialWarningLabel.isHidden = true
            } else if text.hasSpecialCharacters() {
                settingProfileNameWarningLabel.isHidden = true
                settingProfileNameSpecialWarningLabel.isHidden = false
            } else {
                settingProfileNameWarningLabel.isHidden = true
                settingProfileNameSpecialWarningLabel.isHidden = true
            }
        }
    }
    
    private func checkStatusTextField() {
        if let text = settingProfileStatusTextField.text {
            if text.count > 20 {
                settingProfileStatusTextField.layer.borderWidth = 1
                settingProfileStatusTextField.layer.borderColor = UIColor.negative20.cgColor
                settingProfileStatusWarningLabel.isHidden = false
                isStatusSatisfied = false
            } else {
                settingProfileStatusTextField.layer.borderWidth = 0
                settingProfileStatusWarningLabel.isHidden = true
                isStatusSatisfied = true
                lastStatus = text
            }
        }
    }
    
    private func checkDoneButton() {
        if isNameSatisfied && isStatusSatisfied  && !(settingProfileNameTextField.text == firstName && settingProfileStatusTextField.text == firstStatus) {
            settingProfileDoneButton.isDisabled = false
        } else {
            settingProfileDoneButton.isDisabled = true
        }
    }
    
    private func getMyInfo() {
        self.getMyInfoFromServer() { [weak self] response in
            guard let self = self else {
                return
            }
            self.firstName = response.memberName
            self.firstStatus = response.statusMessage
            self.lastName = response.memberName
            self.lastStatus = response.statusMessage
            self.lastProfileImage = response.profilePath
        }
    }
    
    private func petchMyInfo() {
        let memberPatchRequest = MemberPatchRequest(memberName: lastName, profilePath: lastProfileImage, statusMessage: lastStatus)
        self.petchMemberInfoFromServer(body: memberPatchRequest) { [weak self] response in
            guard self != nil else { return }
        }
    }
    
    // MARK: - selector
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.settingProfileDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 45)
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
        if textField == settingProfileNameTextField {
            checkNameTextField()
        } else {
            checkStatusTextField()
        }
        checkDoneButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

// MARK: - set buttom action

extension SettingProfileViewController {
    private func setButtomAction() {
        let doneAction = UIAction {[weak self] _ in
            self?.didTappedDoneButton()
        }
        let action = UIAction { [weak self] _ in
            self?.pushSettingProfileImageViewController()
        }

        settingProfileDoneButton.addAction(doneAction, for: .touchUpInside)
        settingProfileButtonView.addAction(action, for: .touchUpInside)
    }
    
    private func didTappedDoneButton() {
        self.petchMyInfo()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func pushSettingProfileImageViewController() {
        let settingProfileImageView = SettingProfileImageViewController()
        if let image = lastProfileImage,
           let name = firstName,
           let status = firstStatus {
            settingProfileImageView.setupProfile(image: image, name: name, status: status)
        }
        settingProfileImageView.profileImageChangeClosure = { [weak self] imageString in
            self?.lastProfileImage = imageString
        }
        settingProfileImageView.settingProfileViewDidPop = { [weak self] didPop in
            self?.isSettingProfileViewPoped = didPop
        }
        self.navigationController?.pushViewController(settingProfileImageView, animated: true)
    }
}


// MARK: - network

extension SettingProfileViewController {
    private func getMyInfoFromServer(completion: @escaping (MemberResponse) -> Void) {
        NetworkService.shared.members.getMemberInfo { result in
            switch result {
            case .success(let response):
                guard let data = response as? MemberResponse else { return }
                completion(data)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }

    private func petchMemberInfoFromServer(body: MemberPatchRequest, completion: @escaping (MemberPatchResponse) -> Void) {
        NetworkService.shared.members.petchMemberInfo(body: body) { result in
            switch result {
            case .success(let response):
                guard let data = response as? MemberPatchResponse else { return }
                completion(data)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
}
