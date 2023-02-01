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
    
    private let backButton = BackButton()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.onboardingNameViewControllerNameLabel
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let nameTextField: TextField = {
        let textField = TextField()
        textField.type = .large
        textField.myPlaceholder = TextLiteral.onboardingNameViewControllerTextFieldPlaceholder
        return textField
    }()
    private lazy var nameDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonText
        button.isDisabled = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    private let disableLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldDisableSignLabel
        label.textColor = .negative20
        label.font = .body2
        label.layer.isHidden = true
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
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        view.addSubview(nameTextField)
        nameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(nameLabel.snp.bottom).offset(SizeLiteral.componentPadding)
        }
        
        view.addSubview(nameDoneButton)
        nameDoneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
        }
        
        view.addSubview(disableLabel)
        disableLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
        }
    }
    
    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        nameTextField.delegate = self
    }
    
    @objc private func didTapDoneButton() {
        if nameTextField.text!.hasCharacters() {
            nameTextField.layer.borderWidth = 0
            disableLabel.isHidden = true
            
            // TODO: - userdefault에 이름 저장
            
        } else {
            nameTextField.layer.borderWidth = 1
            nameTextField.layer.borderColor = UIColor.negative20.cgColor
            nameDoneButton.isDisabled = true
            disableLabel.isHidden = false
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
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
