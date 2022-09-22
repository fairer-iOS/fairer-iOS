//
//  OnboardingProfileViewController.swift
//  fairer-iOS
//
//  Created by by 김유나 on 2022/09/19.
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
        label.text = TextLiteral.onboardingProfileViewControllerProfileLabel
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
        label.text = TextLiteral.onboardingProfileViewControllerCollectionViewLabel
        label.font = .title1
        label.textColor = .gray600
        return label
    }()
    private let onboardingProfileGroupCollectionView = OnboardingProfileGroupCollectionView()
    private lazy var profileDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.onboardingProfileViewControllerDoneButtonText
        button.isDisabled = true
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapImage()
    }
    
    override func render() {
        view.addSubview(profileLabel)
        profileLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(profileDoneButton)
        profileDoneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        view.addSubview(onboardingProfileGroupCollectionView)
        onboardingProfileGroupCollectionView.snp.makeConstraints {
            $0.top.equalTo(collectionViewLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(profileDoneButton.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - functions
    
    @objc private func didTapDoneButton() {
        print("버튼 누름")
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func didTapImage() {
        onboardingProfileGroupCollectionView.didTappedImage = { [weak self] image in
            self?.selectedProfileImageView.image = image
            guard let selectedImage = self?.selectedProfileImageView.image else { return }
            if selectedImage != ImageLiterals.profileNone {
                self?.profileDoneButton.isDisabled = false
            }
        }
    }
}
