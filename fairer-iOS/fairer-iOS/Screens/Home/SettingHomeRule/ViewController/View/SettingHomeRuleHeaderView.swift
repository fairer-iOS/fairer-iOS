//
//  SettingHomeRuleHeaderView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/03/15.
//

import UIKit

import SnapKit

final class SettingHomeRuleHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "SettingHomeRuleHeaderView"
    
    private let settingHomeRulePrimaryLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRulePrimaryLabel
        label.textColor = .gray800
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
    var settingHomeRuleTextField = TextField(type: .medium, placeHolder: TextLiteral.settingHomeRuleTextFieldPlaceholder)
    private let settingHomeRuleTextFieldeWarningLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "텍스트는 16글자를 초과하여 입력하실 수 없어요.", lineHeight: 22)
        label.textColor = .negative20
        label.font = .body2
        return label
    }()
    private let settingHomeRuleInfoLabel: InfoLabelView = {
        let label = InfoLabelView()
        label.text = TextLiteral.settingHomeRuleInfoLabel
        label.textColor = .gray600
        label.imageColor = .gray200
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeRuleViewRuleLabel
        label.textColor = .gray600
        label.font = .h2
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        render()
        NotificationCenter.default.addObserver(self, selector: #selector(showWarningLabel), name: Notification.Name("showWarningLabel"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideWarningLabel), name: Notification.Name("hideWarningLabel"), object: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        
        addSubviews(settingHomeRulePrimaryLabel, settingHomeRuleTextFieldLabel, settingHomeRuleTextField, settingHomeRuleTextFieldeWarningLabel, settingHomeRuleInfoLabel, titleLabel)
        
        settingHomeRulePrimaryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
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
        
        settingHomeRuleTextFieldeWarningLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(0)
        }
                
        settingHomeRuleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextFieldeWarningLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleInfoLabel.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
    }

}

extension SettingHomeRuleHeaderView {
    
    @objc func showWarningLabel() {
        self.settingHomeRuleTextFieldeWarningLabel.snp.updateConstraints {
            $0.height.equalTo(22)
        }
    }
    
    @objc func hideWarningLabel() {
        self.settingHomeRuleTextFieldeWarningLabel.snp.updateConstraints {
            $0.height.equalTo(0)
        }
    }
}
