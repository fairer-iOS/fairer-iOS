//
//  ChangeHouseNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/30.
//

import UIKit

final class ChangeHouseNameViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let changeHouseNameTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "하우스의 이름을 입력해주세요.", lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let changeHouseNameSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "집의 특성을 잘 보여줄 수 있는 이름도 좋아요!", lineHeight: 26)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let houseNameTextField: TextField = {
        let textField = TextField()
        textField.myPlaceholder = TextLiteral.houseMakeNameViewControllerTextFieldPlaceholder
        textField.text = "즐거운 우리집"
        return textField
    }()
    private lazy var changeHouseNameDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = false
        button.title = "입력 완료"
        let action = UIAction { [weak self] _ in
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
        view.addSubview(changeHouseNameTitleLabel)
        changeHouseNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameSecondaryLabel)
        changeHouseNameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseNameTextField)
        houseNameTextField.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameDoneButton)
        changeHouseNameDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
        houseNameTextField.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.changeHouseNameDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 35)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.changeHouseNameDoneButton.transform = .identity
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - extension

extension ChangeHouseNameViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 16 else { return false }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasText = houseNameTextField.hasText
        changeHouseNameDoneButton.isDisabled = !hasText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        houseNameTextField.layer.borderWidth = 0
        view.endEditing(true)
    }
}
