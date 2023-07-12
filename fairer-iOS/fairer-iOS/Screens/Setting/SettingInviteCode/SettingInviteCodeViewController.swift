//
//  SettingInviteCodeViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/04/09.
//

import UIKit

import SnapKit
import KakaoSDKShare
import KakaoSDKCommon
import KakaoSDKTemplate
import SafariServices
import FirebaseDynamicLinks

final class SettingInviteCodeViewController: BaseViewController {
    
    private var inviteCode: String?
    private var dynamicLink: String?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInviteCodeViewInfo()
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
                self?.inviteCode = data.inviteCode
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
                self?.inviteCode = data.inviteCode
                self?.bindViewData(houseName: houseName, inviteCode: inviteCode, inviteCodeTimeString: inviteCodeTimeString)
                self?.setupButtonLayer(validTime: inviteCodeTimeDate)
            }
        }
    }
    
    private func setButtonAction() {
        let kakaoShare = UIAction { [weak self] _ in
            var dynamicLink: URL = URL(fileURLWithPath: "")
            if let inviteCode = self?.inviteCode {
                dynamicLink = self?.createDynamicLink(inviteCode: inviteCode) ?? URL(fileURLWithPath: "")
            }
            self?.sharedKakaoAPI(dynamicLink: dynamicLink)
        }
        self.inviteCodeButtonView.kakaoShareButton.addAction(kakaoShare, for: .touchUpInside)
    }
    
    private func sharedKakaoAPI(
        dynamicLink: URL
    ) {
        // MARK: - templete
        let appStoreURL = URL(string: TextLiteral.appStoreUrlText)!
        let link = Link(webUrl: appStoreURL, mobileWebUrl: appStoreURL)
        let content: Content = Content(
            title: TextLiteral.contentTitleText,
            imageUrl: URL(string: TextLiteral.contentImageUrlText)!,
            link: link
        )
        let button: [Button] = [Button(title: TextLiteral.templeteButtonTitleText, link: link)]
        let feedTemplate: FeedTemplate = FeedTemplate(
            content: content,
            buttons: button
        )
        
        // MARK: - kakao share
        if ShareApi.isKakaoTalkSharingAvailable() {
            ShareApi.shared.shareDefault(templatable: feedTemplate) { (sharingResult, error) in
                if let error = error {
                    print(error)
                } else {
                    if let sharingResult = sharingResult {
                        UIApplication.shared.open(
                            sharingResult.url,
                            options: [:],
                            completionHandler: nil
                        )
                    }
                }
            }
        } else {
            // 카카오톡 미설치: 웹 공유 사용 권장
            // Custom WebView 또는 디폴트 브라우져 사용 가능
            // 웹 공유 예시 코드
            if let url = ShareApi.shared.makeDefaultUrl(templatable: feedTemplate) {
                self.safariViewController = SFSafariViewController(url: url)
                self.safariViewController?.modalTransitionStyle = .crossDissolve
                self.safariViewController?.modalPresentationStyle = .overCurrentContext
                self.present(self.safariViewController!, animated: true) {
                    print("웹 present success")
                }
            }
        }
    }
    
    private func createDynamicLink(
        inviteCode: String
    ) -> URL {
        guard let webLink = URL(string: "https://www.apple.com/kr/app-store/") else {
            return URL(fileURLWithPath: "")
        }
        let dynamicLinksDomainURIPrefix = "https://example.com/\(inviteCode)"
        let bundleID = "com.ios.fairer"
        guard let linkBuilder = DynamicLinkComponents(link: webLink, domainURIPrefix: dynamicLinksDomainURIPrefix) else {
            return URL(fileURLWithPath: "")
        }
        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleID)

        guard let longDynamicLink = linkBuilder.url else {
            return URL(fileURLWithPath: "")
        }
        print("The long URL is: \(longDynamicLink)")
        return longDynamicLink
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
