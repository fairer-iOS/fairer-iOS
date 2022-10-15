//
//  EnterHouseViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/15.
//

import UIKit

import SnapKit

final class EnterHouseViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton()
    private let enterHousePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "초대코드를 입력해주세요.", lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let enterHouseSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "초대코드를 입력 후 바로 공간에 참여할 수 있어요!", lineHeight: 26)
        label.font = .body1
        label.textColor = .gray400
        return label
    }()
    private let enterHouseCodeTextfield: TextField = {
        let textfield = TextField()
        textfield.myPlaceholder = "12글자 입력"
        return textfield
    }()
    private let enterHouseDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = true
        button.title = TextLiteral.doneButtonText
        return button
    }()

    // MARK: - lifecycle
    
    override func render() {
        view.addSubview(enterHousePrimaryLabel)
        enterHousePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseSecondaryLabel)
        enterHouseSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(enterHousePrimaryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseCodeTextfield)
        enterHouseCodeTextfield.snp.makeConstraints {
            $0.top.equalTo(enterHouseSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(enterHouseDoneButton)
        enterHouseDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
