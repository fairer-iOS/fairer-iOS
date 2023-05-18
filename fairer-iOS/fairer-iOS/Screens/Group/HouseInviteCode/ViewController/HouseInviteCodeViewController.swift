//
//  HouseInviteCodeViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/04.
//

import UIKit

import SnapKit
import KakaoSDKShare
import SafariServices

final class HouseInviteCodeViewController: BaseViewController {
    
    var houseName: String
    var inviteCode: String
    private let templateId: Int = 92371

    init(houseName: String, inviteCode: String) {
        self.houseName = houseName
        self.inviteCode = inviteCode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - property
    
    private var safariViewController : SFSafariViewController?
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
        label.setTextWithLineHeight(text: houseName + TextLiteral.houseInviteCodeViewControllerInviteCodeLabel, lineHeight: 22)
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
        let view = InviteCodeButtonView()
        view.isHidden = true
        view.code = inviteCode
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setButtonAction()
        getinviteCodeExpirationDateTime()
    }
    
    override func configUI() {
        super.configUI()
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
    
    private func setButtonAction() {
        let kakaoShare = UIAction { [weak self] _ in
            self?.sharedKakaoAPI()
        }
        self.inviteCodeButtonView.kakaoShareButton.addAction(kakaoShare, for: .touchUpInside)
    }
    
    private func bindViewData(inviteCode: String, inviteCodeTimeString: String) {
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
                 self?.bindViewData(inviteCode: inviteCode, inviteCodeTimeString: inviteCodeTimeString)
                 self?.setupButtonLayer(validTime: inviteCodeTimeDate)
             }
         }
    }
    
    private func getinviteCodeExpirationDateTime() {
        getInviteCodeInfo { [weak self] data in
            if let inviteCodeTimeString = data.inviteCodeExpirationDateTime?.iso8601ToKoreanString,
               let inviteCodeTimeDate = data.inviteCodeExpirationDateTime?.iso8601ToDay
            {
                self?.validTimeLabel.text = inviteCodeTimeString + TextLiteral.houseInviteCodeViewControllerValidTimeLabel
                self?.setupButtonLayer(validTime: inviteCodeTimeDate)
            }
        }
    }
    
    private func sharedKakaoAPI() {
        if ShareApi.isKakaoTalkSharingAvailable() {
            ShareApi.shared.shareCustom(templateId: Int64(templateId), templateArgs:["title":"제목입니다.", "description":"설명입니다."]) {(sharingResult, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("shareCustom() success.")
                    if let sharingResult = sharingResult {
                        UIApplication.shared.open(sharingResult.url, options: [:], completionHandler: nil)
                    }
                }
            }
        } else {
            if let url = ShareApi.shared.makeCustomUrl(templateId: Int64(templateId), templateArgs:["title":"제목입니다.", "description":"설명입니다."]) {
                self.safariViewController = SFSafariViewController(url: url)
                self.safariViewController?.modalTransitionStyle = .crossDissolve
                self.safariViewController?.modalPresentationStyle = .overCurrentContext
                self.present(self.safariViewController!, animated: true) {
                    print("웹 present success")
                }
            }
        }
    }
}

extension HouseInviteCodeViewController {
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

// MARK: - navigation control

extension HouseInviteCodeViewController {
    
    private func setButtonAction() {
        let moveToHomeViewAction = UIAction { [weak self] _ in
            self?.moveToHomeView()
        }
        
        //MARK: - to do 카카오 공유하기 버튼 연결 추가로 해야함
        self.inviteCodeButtonView.skipButton.addAction(moveToHomeViewAction, for: .touchUpInside)
    }
    
    private func moveToHomeView() {
        let homeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
}
