//
//  OnboardingNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/18.
//

import UIKit

import SnapKit

final class OnboardingNameViewController: BaseViewController {
    
    private let nameMaxLength = 5
    
    // MARK: - property
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요."
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let nameTextField: UITextField = {
        let textField = UITextField()
        let attributes = [
            NSAttributedString.Key.font: UIFont.h3,
            NSAttributedString.Key.foregroundColor: UIColor.gray400
        ]
        textField.backgroundColor = .normal0
        textField.font = .h3
        textField.attributedPlaceholder = NSAttributedString(string: "예) 홍길동", attributes: attributes)
        textField.layer.cornerRadius = 8
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 58))
        textField.leftViewMode = .always
        textField.setClearButton(with: ImageLiterals.textFieldClearButton, mode: .whileEditing)
        return textField
    }()
    private let nameDoneButton: MainButton = {
        let button = MainButton()
        button.title = "입력 완료"
        button.isDisabled = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    private let disableLabel: UILabel = {
        let label = UILabel()
        label.text = "&,!,#,@,^와 같은 특수문자는 입력하실 수 없어요."
        label.textColor = .negative20
        label.font = .body2
        label.layer.opacity = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupNotificationCenter()
    }
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.top.equalToSuperview().offset(111)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.height.equalTo(58)
        }
        
        view.addSubview(nameDoneButton)
        nameDoneButton.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
            $0.bottom.equalToSuperview().offset(-36)
        }
        
        view.addSubview(disableLabel)
        disableLabel.snp.makeConstraints {
            $0.leading.equalTo(24)
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
        }
    }
    
    // MARK: - functions
    
    private func setupDelegation() {
        nameTextField.delegate = self
    }
    
    @objc private func didTapDoneButton() {
        if nameTextField.text!.hasCharacters() {
            nameTextField.layer.borderWidth = 0
            disableLabel.layer.opacity = 0
        } else {
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = UIColor.negative20.cgColor
            disableLabel.layer.opacity = 1
        }
        print(nameTextField.text!)
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.nameDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 20)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.nameDoneButton.transform = .identity
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - extension

extension OnboardingNameViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 5 else { return false }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasText = nameTextField.hasText
        nameDoneButton.isDisabled = !hasText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.layer.borderWidth = 0
        view.endEditing(true)
    }
}
