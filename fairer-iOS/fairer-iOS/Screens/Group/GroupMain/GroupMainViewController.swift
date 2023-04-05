//
//  GroupMainViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/26.
//

import UIKit

import SnapKit

final class GroupMainViewController: BaseViewController {
    
    private var userName:String = String() {
        didSet {
            titleLabel.text = "안녕하세요. \(userName)님!\n새로 하우스를 만들거나 참여해주세요."
            titleLabel.applyColor(to: userName, with: .blue)
        }
    }
    // MARK: - property
    
    private let backButton = BackButton()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요. 님!\n새로 하우스를 만들거나 참여해주세요."
        label.font = .h2
        label.textColor = .gray800
        label.numberOfLines = 0
        return label
    }()
    private let houseMakeLabel: UILabel = {
       let label = UILabel()
        label.text = TextLiteral.groupMainViewControllerHouseMakeLabel
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseMakeButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.groupMainViewControllerHouseMakeButtonText
        return button
    }()
    private let houseMakeInfo: InfoLabelView = {
        let view = InfoLabelView()
        view.text = TextLiteral.groupMainViewControllerHouseMakeInfoLabel
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
        label.text = TextLiteral.groupMainViewControllerHouseEnterLabel
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseEnterButton: UIButton = {
       let button = UIButton()
        button.setTitle(TextLiteral.groupMainViewControllerHouseEnterButtonText, for: .normal)
        button.setTitleColor(UIColor.gray800, for: .normal)
        button.backgroundColor = .normal0
        button.titleLabel?.font = .title1
        button.layer.cornerRadius = 8
        return button
    }()
    private let houseEnterInfo: InfoLabelView = {
        let view = InfoLabelView()
        view.text = TextLiteral.groupMainViewControllerHouseEnterInfoLabel
        view.imageColor = .gray200
        view.textColor = .gray600
        return view
    }()
    
    // MARK: - life cycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMemberInfo()
    }
    
    override func render() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
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
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
        
        view.addSubview(houseEnterInfo)
        houseEnterInfo.snp.makeConstraints {
            $0.top.equalTo(houseEnterButton.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(44)
        }
    }
}

extension GroupMainViewController {
    func getMemberInfo() {
        NetworkService.shared.members.getMemberInfo { [weak self] result in
            switch result {
            case .success(let response):
                guard let memberData = response as? MemberResponse else { return }
                if let memberName = memberData.memberName {
                    self?.userName = memberName
                }
            case .requestErr(let error):
                dump(error)
            default:
                print("server Error")
            }
        }
    }
}
