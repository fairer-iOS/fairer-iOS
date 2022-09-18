//
//  OnboardingNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/18.
//

import UIKit

import SnapKit

final class OnboardingNameViewController: BaseViewController {
    
    // MARK: - property
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요."
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    
    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(24)
            $0.top.equalToSuperview().offset(111)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
    }
}
