//
//  HomeRuleView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/21.
//

import UIKit

import SnapKit

final class HomeRuleView: BaseUIView {
    
    // MARK: - property
    
    let homeRuleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeRuleViewRuleLabel
        label.font = .caption1
        label.textColor = .blue
        return label
    }()
    let homeRuleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        self.backgroundColor = .positive0
        self.layer.cornerRadius = 8
    }
    override func render() {
        self.addSubviews(homeRuleLabel,homeRuleDescriptionLabel)
        
        homeRuleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(18)
        }
        
        homeRuleDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(homeRuleLabel.snp.trailing).offset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(18)
        }
    }
}
