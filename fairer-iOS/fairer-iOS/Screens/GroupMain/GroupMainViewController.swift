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
    private let houseMakeLabel: UILabel = {
       let label = UILabel()
        label.text = "집안일 하우스 생성"
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseMakeButton: MainButton = {
        let button = MainButton()
        button.title = "집안일 하우스 만들기"
        return button
    }()
    private let houseMakeInfo: InfoLabelView = {
        let view = InfoLabelView()
        view.text = "개인 혹은 여러명이 집안일을 관리할 수 있는 하우스를\n만들 수 있습니다."
        view.imageColor = .gray200
        view.textColor = .gray600
        return view
    }()
    private let groupMainDivider: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.normal0.cgColor
        return view
    }()
    private let houseEnterLabel: UILabel = {
       let label = UILabel()
        label.text = "하우스 참여"
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseEnterButton: UIButton = {
       let button = UIButton()
        button.setTitle("집안일 하우스 참여하기", for: .normal)
        button.setTitleColor(UIColor.gray800, for: .normal)
        button.backgroundColor = .normal0
        button.titleLabel?.font = .title1
        button.layer.cornerRadius = 8
        return button
    }()
    private let houseEnterInfo: InfoLabelView = {
        let view = InfoLabelView()
        view.text = "기존에 만들어진 하우스에 참여하고 싶다면\n선택해주세요."
        view.imageColor = .gray200
        view.textColor = .gray600
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
        }
        
        view.addSubview(houseMakeLabel)
        houseMakeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        view.addSubview(houseMakeButton)
        houseMakeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(houseMakeLabel.snp.bottom).offset(16)
        }
        
        view.addSubview(houseMakeInfo)
        houseMakeInfo.snp.makeConstraints {
            $0.top.equalTo(houseMakeButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(44)
        }
        
        view.addSubview(groupMainDivider)
        groupMainDivider.snp.makeConstraints {
            $0.top.equalTo(houseMakeInfo.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.height.equalTo(1)
        }
        
        view.addSubview(houseEnterLabel)
        houseEnterLabel.snp.makeConstraints {
            $0.top.equalTo(groupMainDivider.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(houseEnterButton)
        houseEnterButton.snp.makeConstraints {
            $0.top.equalTo(houseEnterLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
        
        view.addSubview(houseEnterInfo)
        houseEnterInfo.snp.makeConstraints {
            $0.top.equalTo(houseEnterButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(44)
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
