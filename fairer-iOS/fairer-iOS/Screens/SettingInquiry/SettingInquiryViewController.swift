//
//  SettingInquiryViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/20.
//

import UIKit

import SnapKit
import SafariServices
import MessageUI

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
    private let mailCellView: SettingInquiryCellView = {
        let view = SettingInquiryCellView()
        view.inquiryType = .email
        return view
    }()
    private let instagramCellView: SettingInquiryCellView = {
        let view = SettingInquiryCellView()
        view.inquiryType = .instagram
        return view
    }()
    private let composeVC = MFMailComposeViewController()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapMail()
    }
    
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
    
    private func didTapMail() {
        mailCellView.didTappedMail = { () -> () in
            if MFMailComposeViewController.canSendMail() {
                self.setupDelegate()
                
                self.composeVC.setToRecipients(["faireran@gmail.com"])
                self.composeVC.setSubject("[문의]")
                self.composeVC.setMessageBody("문의 내용", isHTML: false)
                
                self.present(self.composeVC, animated: true, completion: nil)
            }
            else {
                self.makeAlert(title: "Mail 앱 연결 실패", message: "이메일 설정을 확인하고 다시 시도해주세요.")
            }
        }
    }
}

// MARK: - extension

extension SettingInquiryViewController: MFMailComposeViewControllerDelegate {
    private func setupDelegate() {
        composeVC.mailComposeDelegate = self
    }
}
