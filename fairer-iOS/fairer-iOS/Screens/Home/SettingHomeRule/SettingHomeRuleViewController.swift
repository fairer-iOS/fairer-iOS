//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

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
        label.textColor = .black
        label.font = .h2
        return label
    }()
    private let settingHomeRuleTextField: TextField = {
        let textField = TextField()
        textField.myPlaceholder = TextLiteral.settingHomeRuleTextFieldPlaceholder
        return textField
    }()
    private let settingHomeRuleInfoPin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.spacePin
        return imageView
    }()
    private let settingHomeRuleInfoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRuleInfoLabel
        label.textColor = .black
        label.font = .body2
        return label
    }()
    
    private lazy var settingHomeRuleInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingHomeRuleInfoPin,settingHomeRuleInfoLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - life cycle
     
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
}
