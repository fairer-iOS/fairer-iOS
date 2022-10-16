//
//  HouseInfoViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/16.
//

import UIKit

import SnapKit

class HouseInfoViewController: BaseViewController {
    
    let houseName: String = "즐거운 우리집"

    // MARK: - property
    
    private let backButton = BackButton()
    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.imgWelcomeHouse
        return imageView
    }()
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: houseName + "에 어서오세요!", lineHeight: 28)
        label.font = .h2
        label.textColor = .gray800
        label.applyColor(to: houseName, with: .blue)
        return label
    }()
    private let houseInfoDivider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.normal0.cgColor
        return view
    }()
    private let houseMemberLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "공간 참여자", lineHeight: 22)
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseInfoDoneButton: MainButton = {
        let button = MainButton()
        button.title = "참여 완료"
        button.isDisabled = false
        return button
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        view.addSubview(welcomeImageView)
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseInfoDivider)
        houseInfoDivider.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(houseMemberLabel)
        houseMemberLabel.snp.makeConstraints {
            $0.top.equalTo(houseInfoDivider.snp.bottom).offset(36)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseInfoDoneButton)
        houseInfoDoneButton.snp.makeConstraints {
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
}
