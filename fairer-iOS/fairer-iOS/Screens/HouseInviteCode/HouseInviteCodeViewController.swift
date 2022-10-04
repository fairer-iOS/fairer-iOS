//
//  HouseInviteCodeViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/04.
//

import UIKit

import SnapKit

final class HouseInviteCodeViewController: BaseViewController {
    
    let houseName: String = "즐거운 우리집"
    let inviteCode: String = "4D1AGE9HE362"
    
    // MARK: - property
    
    private let backButton = BackButton()
    private let houseInvitePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "하우스에 사람을 초대해주세요.", lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let houseInviteSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "앞으로 함께 집안일을 관리할 가족, 친구, 룸메이트\n누구든 초대해주세요!", lineHeight: 26)
        label.numberOfLines = 0
        label.font = .body1
        label.textColor = .gray400
        return label
    }()
    private lazy var inviteCodeLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "\(houseName)의 초대코드", lineHeight: 22)
        label.font = .title1
        label.textColor = .gray600
        label.applyColor(to: houseName, with: .blue)
        return label
    }()
    private lazy var inviteCodeView: InviteCodeView = {
        let view = InviteCodeView()
        view.code = inviteCode
        return view
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        view.addSubview(houseInvitePrimaryLabel)
        houseInvitePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(28)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseInviteSecondaryLabel)
        houseInviteSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(houseInvitePrimaryLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(inviteCodeLabel)
        inviteCodeLabel.snp.makeConstraints {
            $0.top.equalTo(houseInviteSecondaryLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(inviteCodeView)
        inviteCodeView.snp.makeConstraints {
            $0.top.equalTo(inviteCodeLabel.snp.bottom).offset(8)
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
