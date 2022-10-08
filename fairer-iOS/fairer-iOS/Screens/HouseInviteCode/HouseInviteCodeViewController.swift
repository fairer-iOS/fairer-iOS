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
    let validTime: Date = Date()
    
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
    private lazy var validTimeLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.text = validTime.dateToKoreanString + "까지 유효한 코드"
        view.textColor = .negative20
        view.imageColor = .negative20
        return view
    }()
    private lazy var codeInfoLabel: InfoLabelView = {
        let view = InfoLabelView()
        view.text = "초대 받은 사람은 해당 초대코드가 생성된 24시간 안에\n입력하셔야 합니다."
        view.imageColor = .gray200
        view.textColor = .gray600
        return view
    }()
    private lazy var copyCodeButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgCopyCode
        config.imagePlacement = .leading
        config.baseForegroundColor = .blue
        var titleAttr = AttributedString.init("코드 복사하기")
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 4
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = .positive10
        let buttonAction = UIAction { [weak self] _ in
            self?.touchUpToShowToast()
        }
        button.addAction(buttonAction, for: .touchUpInside)
        return button
    }()
    private let kakaoShareButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = ImageLiterals.imgKakaoShare
        config.imagePlacement = .leading
        config.baseForegroundColor = UIColor(red: 0.141, green: 0.051, blue: 0.047, alpha: 1)
        var titleAttr = AttributedString.init("카카오톡 공유하기")
        titleAttr.font = .title1
        config.attributedTitle = titleAttr
        config.imagePadding = 4
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 0.992, green: 0.945, blue: 0.38, alpha: 1)
        return button
    }()
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.titleLabel?.font = .title1
        button.setTitleColor(.gray800, for: .normal)
        button.backgroundColor = .white
        return button
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
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(2)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
        
        view.addSubview(kakaoShareButton)
        kakaoShareButton.snp.makeConstraints {
            $0.bottom.equalTo(skipButton.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
        
        view.addSubview(copyCodeButton)
        copyCodeButton.snp.makeConstraints {
            $0.bottom.equalTo(kakaoShareButton.snp.top).offset(-8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
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
    
    private func touchUpToShowToast() {
        UIPasteboard.general.string = inviteCode
        showToast()
    }
    
    private func showToast() {
        let toastLabel = UILabel()
        toastLabel.text = "코드를 클립보드에 복사했습니다."
        toastLabel.textColor = .white
        toastLabel.font = .title2
        toastLabel.backgroundColor = .gray700
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        toastLabel.alpha = 0
        view.addSubview(toastLabel)
        toastLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(22)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(36)
        }
        UIView.animate(withDuration: 1.0, animations: {
            toastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 1.0, animations: {
                toastLabel.alpha = 0
            }, completion: { isCompleted in
                toastLabel.removeFromSuperview()
            })
        })
        
    }
}
