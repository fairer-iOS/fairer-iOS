//
//  SettingInquiryViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/20.
//

import UIKit

import SnapKit

final class SettingInquiryViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingInquiryTitleLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "궁금한 점이 있으시다면\n아래 연락처를 통해 문의해주세요.", lineHeight: 28)
        label.textColor = .gray800
        label.font = .h2
        label.numberOfLines = 2
        return label
    }()
    private let mailCellView = SettingInquiryCellView()
    private let instagramCellView = SettingInquiryCellView()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(settingInquiryTitleLabel)
        settingInquiryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(mailCellView)
        mailCellView.snp.makeConstraints {
            $0.top.equalTo(settingInquiryTitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(54)
        }
        
        view.addSubview(instagramCellView)
        instagramCellView.snp.makeConstraints {
            $0.top.equalTo(mailCellView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(54)
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
