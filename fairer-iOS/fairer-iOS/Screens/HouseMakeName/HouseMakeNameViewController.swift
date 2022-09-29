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

    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        button.tintColor = .gray800
        return button
    }()
    private let writeNamePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "하우스의 이름을 입력해주세요.", lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let writeNameSecondaryLabel: UILabel = {
       let label = UILabel()
        label.setTextWithLineHeight(text: "집의 특성을 잘 보여줄 수 있는 이름도 좋아요!", lineHeight: 26)
        label.font = .body1
        label.textColor = .gray400
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle

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
    }
    
    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
