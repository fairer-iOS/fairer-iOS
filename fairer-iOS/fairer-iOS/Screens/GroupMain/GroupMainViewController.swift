//
//  GroupMainViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/26.
//

import UIKit

import SnapKit

final class GroupMainViewController: BaseViewController {
    
    let userName: String = "고가혜"
    
    // MARK: - property
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        button.tintColor = .gray800
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요. \(userName)님!\n새로 하우스를 만들거나 참여해주세요."
        label.font = .h2
        label.textColor = .gray800
        label.applyColor(to: userName, with: .blue)
        label.numberOfLines = 0
        // TODO: - LoginView pull 받아서 lineheight extension 적용
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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
