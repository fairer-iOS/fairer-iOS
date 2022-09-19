//
//  OnboardingProfileViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/19.
//

import UIKit

import SnapKit

class OnboardingProfileViewController: BaseViewController {
    
    // MARK: - property
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.setImage(ImageLiterals.navigationBarBackButton, for: .normal)
        button.tintColor = .gray800
        return button
    }()
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 사진을 골라주세요."
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    private let selectedProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ImageLiterals.profileNone
        return imageView
    }()
    private let collectionViewLabel: UILabel = {
       let label = UILabel()
        label.text = "기본 프로필 선택"
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
        
        view.addSubview(selectedProfileImageView)
        selectedProfileImageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileLabel.snp.bottom).offset(24)
        }
        
        view.addSubview(collectionViewLabel)
        collectionViewLabel.snp.makeConstraints {
            $0.top.equalTo(selectedProfileImageView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(24)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
}
