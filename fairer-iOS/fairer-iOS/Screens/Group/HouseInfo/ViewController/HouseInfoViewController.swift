//
//  HouseInfoViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/16.
//

import UIKit

import SnapKit

final class HouseInfoViewController: BaseViewController {
        
    var houseName:String = "" {
        didSet {
            welcomeLabel.setTextWithLineHeight(text: (houseName) + TextLiteral.houseInfoViewControllerWelcomeLabel, lineHeight: 28)
            welcomeLabel.applyColor(to: houseName, with: .blue)
        }
    }
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let welcomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.imgWelcomeHouse
        return imageView
    }()
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .h2
        label.textColor = .gray800
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
        label.setTextWithLineHeight(text: TextLiteral.houseInfoViewControllerHouseMemberLabel, lineHeight: 22)
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let houseMemberCollectionView = HouseMemberCollectionView()
    private let houseInfoDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.houseInfoViewControllerHouseInfoDoneButtonText
        return button
    }()
    
    // MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTeamInfo()
    }
    
    override func render() {
        view.addSubview(welcomeImageView)
        welcomeImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeImageView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(28)
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
        
        view.addSubview(houseMemberCollectionView)
        houseMemberCollectionView.snp.makeConstraints {
            $0.top.equalTo(houseMemberLabel.snp.bottom)
            $0.bottom.equalTo(houseInfoDoneButton.snp.top)
            $0.leading.trailing.equalToSuperview()
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

extension HouseInfoViewController {
    
    func getTeamInfo() {
        NetworkService.shared.teams.getTeamInfo { [weak self] result in
            switch result {
            case .success(let response):
                guard let teamInfo = response as? TeamInfoResponse else { return }
                guard let membersInfo = teamInfo.members else { return }
                guard let teamName = teamInfo.teamName else { return }
                
                DispatchQueue.main.async {
                    self?.houseMemberCollectionView.teamInfoData = membersInfo
                    self?.houseName = teamName
                }
            case .requestErr(let error):
                dump(error)
            default:
                print("server error")
            }
        }
    }
}
