//
//  AlreadyInGroupViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/01.
//

import UIKit

import SnapKit

final class AlreadyInGroupViewController: BaseViewController {
    
    // MARK: - property
    
    private let alreadyInGroupTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "이미 그룹에 참여되어 있습니다.\n새로운 그룹에 참여하려면\n기존의 그룹에서 나가주세요.", lineHeight: 28)
        label.numberOfLines = 0
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(alreadyInGroupTitleLabel)
        alreadyInGroupTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
}
