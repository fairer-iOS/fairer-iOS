//
//  ChangeHouseNameViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/30.
//

import UIKit

final class ChangeHouseNameViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let changeHouseNameTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "하우스의 이름을 입력해주세요.", lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let changeHouseNameSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "집의 특성을 잘 보여줄 수 있는 이름도 좋아요!", lineHeight: 26)
        label.textColor = .gray400
        label.font = .body1
        return label
    }()
    private let houseNameTextField: TextField = {
        let textField = TextField()
        textField.myPlaceholder = TextLiteral.houseMakeNameViewControllerTextFieldPlaceholder
        textField.text = "즐거운 우리집"
        return textField
    }()
    private lazy var changeHouseNameDoneButton: MainButton = {
        let button = MainButton()
        button.isDisabled = false
        button.title = "입력 완료"
        let action = UIAction { [weak self] _ in
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(changeHouseNameTitleLabel)
        changeHouseNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameSecondaryLabel)
        changeHouseNameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameTitleLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseNameTextField)
        houseNameTextField.snp.makeConstraints {
            $0.top.equalTo(changeHouseNameSecondaryLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(changeHouseNameDoneButton)
        changeHouseNameDoneButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
