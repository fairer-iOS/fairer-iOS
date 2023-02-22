//
//  AlreadyInGroupViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/01.
//

import UIKit

import SnapKit
import SwiftUI

final class AlreadyInGroupViewController: BaseViewController {
    
    // MARK: - property
    
    private let alreadyInGroupTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.alreadyInGroupViewControllerTitleLabel, lineHeight: 28)
        label.numberOfLines = 0
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let alreadyInGroupInfoLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.textColor = .gray600
        view.text = TextLiteral.alreadyInGroupViewControllerInfoLabel
        view.imageColor = .gray200
        return view
    }()
    private let alreadyHouseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.imgAlreadyHouse
        return imageView
    }()
    private let backToMainButton: MainButton = {
        let button = MainButton()
        button.isDisabled = false
        button.title = TextLiteral.alreadyInGroupViewControllerDoneButtonText
        return button
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
        
        view.addSubview(backToMainButton)
        backToMainButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
}
