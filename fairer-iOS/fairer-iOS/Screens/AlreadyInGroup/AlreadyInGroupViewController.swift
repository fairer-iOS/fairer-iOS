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
    private let alreadyInGroupInfoLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.textColor = .gray600
        view.text = "기존의 그룹에서 나가는 경로는\n’설정>그룹 관리>그룹에서 나가기’ 입니다."
        view.imageColor = .gray200
        return view
    }()
    private let alreadyHouseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.imgAlreadyHouse
        return imageView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(alreadyInGroupTitleLabel)
        alreadyInGroupTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(alreadyInGroupInfoLabel)
        alreadyInGroupInfoLabel.snp.makeConstraints {
            $0.top.equalTo(alreadyInGroupTitleLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(alreadyHouseImageView)
        alreadyHouseImageView.snp.makeConstraints {
            $0.top.equalTo(alreadyInGroupInfoLabel.snp.bottom).offset(120)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(144)
        }
    }
    
    // MARK: - func
    
}
