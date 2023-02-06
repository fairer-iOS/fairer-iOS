//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

import SnapKit

class SettingHomeRuleViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    
    private let settingHomeRulePrimaryLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRulePrimaryLabel
        label.textColor = .black
        label.font = .h2
        return label
    }()
    private let settingHomeRuleTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRuleTextFieldLabel
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let settingHomeRuleTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray200.cgColor
        textField.myPlaceholder = TextLiteral.settingHomeRuleTextFieldPlaceholder
        textField.setClearButton()
        return textField
    }()
    private let settingHomeRuleInfoPin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.settingInfo
        return imageView
    }()
    private let settingHomeRuleInfoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRuleInfoLabel
        label.textColor = .gray600
        label.font = .body2
        return label
    }()
    
    private lazy var settingHomeRuleInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingHomeRuleInfoPin,settingHomeRuleInfoLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    override func render() {
        view.addSubviews(settingHomeRulePrimaryLabel, settingHomeRuleTextFieldLabel, settingHomeRuleTextField, settingHomeRuleInfoStackView)
        
        settingHomeRulePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleTextFieldLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRulePrimaryLabel.snp.bottom).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleTextField.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextFieldLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleInfoStackView.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextField.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
     
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        settingHomeRuleTextField.delegate = self
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
            if let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frameValue.cgRectValue.height
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y -= (height - self.view.safeAreaInsets.bottom)
                })
            }
        }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        
        if let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frameValue.cgRectValue.height
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.frame.origin.y += (height - self.view.safeAreaInsets.bottom)
            })
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - extension

extension SettingHomeRuleViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
