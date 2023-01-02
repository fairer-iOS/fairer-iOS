//
//  SettingPolicyViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/27.
//

import UIKit

import SnapKit

final class SettingPolicyViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentLabel: UILabel = {
       let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingPolicyViewControllerPolicyContent, lineHeight: 22)
        label.textColor = .gray800
        label.font = .body2
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.edges.equalToSuperview()
        }
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
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
        navigationItem.title = TextLiteral.settingPolicyViewControllerNavigationBarTitle
    }
}
