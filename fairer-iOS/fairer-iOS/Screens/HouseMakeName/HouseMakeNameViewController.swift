//
//  HouseMakeNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/29.
//

import UIKit

import SnapKit

final class HouseMakeNameViewController: BaseViewController {

    // MARK: - property

    private let backButton = BackButton()
    private let writeNamePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.houseMakeNameViewControllerWriteNamePrimaryLabel, lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let writeNameSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.houseMakeNameViewControllerWriteNameSecondaryLabel, lineHeight: 26)
        label.font = .body1
        label.textColor = .gray400
        label.numberOfLines = 0
        return label
    }()
    private let houseNameTextField: TextField = {
        let textField = TextField(type: .large)
        textField.myPlaceholder = TextLiteral.houseMakeNameViewControllerTextFieldPlaceholder
        return textField
    }()
    private let disableLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.textFieldDisableSignLabel
        label.textColor = .negative20
        label.font = .body2
        label.layer.isHidden = true
        return label
    }()
    private lazy var houseNameDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.doneButtonText
        button.isDisabled = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupNotificationCenter()
    }

    override func render() {
        view.addSubview(writeNamePrimaryLabel)
        writeNamePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(writeNameSecondaryLabel)
        writeNameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(writeNamePrimaryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseNameTextField)
        houseNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(writeNameSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
        }
        
        view.addSubview(disableLabel)
        disableLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(houseNameTextField.snp.bottom).offset(8)
        }
        
        view.addSubview(houseNameDoneButton)
        houseNameDoneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
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
        houseNameTextField.delegate = self
    }
    
    @objc private func didTapDoneButton() {
        if houseNameTextField.text!.hasCharacters() {
            houseNameTextField.layer.borderWidth = 0
            disableLabel.isHidden = true
            
            // TODO: - userdefault에 하우스 이름 저장
            
        } else {
            houseNameTextField.layer.borderWidth = 1
            houseNameTextField.layer.borderColor = UIColor.negative20.cgColor
            houseNameDoneButton.isDisabled = true
            disableLabel.isHidden = false
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.houseNameDoneButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 20)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.houseNameDoneButton.transform = .identity
        })
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - extension

extension HouseMakeNameViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 10 else { return false }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let hasText = houseNameTextField.hasText
        houseNameDoneButton.isDisabled = !hasText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        houseNameTextField.layer.borderWidth = 0
        view.endEditing(true)
    }
}
