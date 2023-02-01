//
//  WriteHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/02/01.
//

import UIKit

import SnapKit

final class WriteHouseWorkViewController: BaseViewController {
    
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    // FIXME: - PR 머지되면 Calendar View Global 로
    private let writeHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let houseWorkNameLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "집안일 이름", lineHeight: 22)
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let houseWorkNameTextField: TextField = {
        let textField = TextField()
        textField.type = .small
        textField.myPlaceholder = "직접 입력"
        return textField
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubviews(writeHouseWorkCalendarView, houseWorkNameLabel, houseWorkNameTextField)
        
        writeHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        houseWorkNameLabel.snp.makeConstraints {
            $0.top.equalTo(writeHouseWorkCalendarView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        houseWorkNameTextField.snp.makeConstraints {
            $0.top.equalTo(houseWorkNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
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
