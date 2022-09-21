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
    
    private let homeRuleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeRuleViewRuleLabel
        label.font = .caption1
        label.textColor = .blue
        return label
    }()
    private let homeRuleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeRuleViewRuleDescriptionLabel
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
        self.addSubview(homeRuleLabel)
        homeRuleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        self.addSubview(homeRuleDescriptionLabel)
        homeRuleDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(homeRuleLabel.snp.trailing).offset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
}
