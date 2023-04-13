//
//  SettingInviteCodeViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/09.
//

import UIKit

import SnapKit

final class SettingInviteCodeViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton()
    private let houseInvitePrimaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.houseInviteCodeViewControllerPrimaryLabel, lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let houseInviteSecondaryLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.houseInviteCodeViewControllerSecondaryLabel, lineHeight: 26)
        label.numberOfLines = 0
        label.font = .body1
        label.textColor = .gray400
        return label
    }()
    private lazy var inviteCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private lazy var inviteCodeView: InviteCodeView = {
        let view = InviteCodeView()
        return view
    }()
    private lazy var validTimeLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.textColor = .negative20
        view.imageColor = .negative20
        return view
    }()
    private lazy var codeInfoLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.text = TextLiteral.houseInviteCodeViewControllerCodeInfoLabel
        view.imageColor = .gray200
        view.textColor = .gray600
        return view
    }()
    private lazy var inviteCodeButtonView: InviteCodeButtonView = {
        let view = InviteCodeButtonView(skipButtonisHidden: true)
        view.isHidden = true
        return view
    }()
    private lazy var refreshCodeButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.houseInviteCodeViewControllerRefreshButtonText
        button.isHidden = true
        let action = UIAction { [weak self] _ in
            self?.touchUpToRefeshButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - lifecycle
    
    override func configUI() {
        super.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInviteCodeViewInfo()
    }
    
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
        
        view.addSubview(validTimeLabel)
        validTimeLabel.snp.makeConstraints {
            $0.top.equalTo(inviteCodeView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        view.addSubview(codeInfoLabel)
        codeInfoLabel.snp.makeConstraints {
            $0.top.equalTo(validTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(inviteCodeButtonView)
        inviteCodeButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(refreshCodeButton)
        refreshCodeButton.snp.makeConstraints {
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
    
    private func setupButtonLayer(validTime: Date) {
        if validTime > Date() {
            inviteCodeButtonView.isHidden = false
        } else {
            refreshCodeButton.isHidden = false
        }
    }
    
    private func bindViewData(houseName: String, inviteCode: String, inviteCodeTimeString: String) {
        inviteCodeLabel.setTextWithLineHeight(text: houseName + TextLiteral.houseInviteCodeViewControllerInviteCodeLabel, lineHeight: 22)
        inviteCodeLabel.applyColor(to: houseName, with: .blue)
        inviteCodeView.code = inviteCode
        inviteCodeButtonView.code = inviteCode
        validTimeLabel.text = inviteCodeTimeString + TextLiteral.houseInviteCodeViewControllerValidTimeLabel
    }
    
    private func touchUpToRefeshButton() {
        getInviteCodeInfo { [weak self] data in
            if let inviteCode = data.inviteCode,
               let inviteCodeTimeString = data.inviteCodeExpirationDateTime?.iso8601ToKoreanString,
               let inviteCodeTimeDate = data.inviteCodeExpirationDateTime?.iso8601ToDay
            {
                self?.inviteCodeView.code = inviteCode
                self?.inviteCodeButtonView.code = inviteCode
                self?.validTimeLabel.text = inviteCodeTimeString + TextLiteral.houseInviteCodeViewControllerValidTimeLabel
                self?.setupButtonLayer(validTime: inviteCodeTimeDate)
            }
        }
    }
    
    private func getInviteCodeViewInfo() {
        getInviteCodeInfo { [weak self] data in
            if let houseName = data.teamName,
               let inviteCode = data.inviteCode,
               let inviteCodeTimeString = data.inviteCodeExpirationDateTime?.iso8601ToKoreanString,
               let inviteCodeTimeDate = data.inviteCodeExpirationDateTime?.iso8601ToDay
            {
                self?.bindViewData(houseName: houseName, inviteCode: inviteCode, inviteCodeTimeString: inviteCodeTimeString)
                self?.setupButtonLayer(validTime: inviteCodeTimeDate)
            }
        }
    }
}

extension SettingInviteCodeViewController {
    func getInviteCodeInfo(completion: @escaping (InviteCodeInfoResponse) -> Void) {
        NetworkService.shared.teams.getInviteCodeInfo { result in
            switch result {
            case .success(let response):
                guard let inviteCodeInfoData = response as? InviteCodeInfoResponse else { return }
                completion(inviteCodeInfoData)
            case .requestErr(let error):
                dump(error)
            default:
                print("server error")
            }
        }
    }
}
