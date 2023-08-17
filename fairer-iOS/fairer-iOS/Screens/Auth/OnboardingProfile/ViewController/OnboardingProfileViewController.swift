//
//  OnboardingProfileViewController.swift
//  fairer-iOS
//
//  Created by by 김유나 on 2022/09/19.
//

import UIKit

import SnapKit

class OnboardingProfileViewController: BaseViewController {
    
    private var userName: String?
    private var userImage: String?
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let profileLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.onboardingProfileViewControllerProfileLabel
        label.font = .h2
        label.textColor = .gray800
        return label
    }()
    let selectedProfileImageView: UIImageView = {
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
    let onboardingProfileGroupCollectionView = OnboardingProfileGroupCollectionView()
    lazy var profileDoneButton: MainButton = {
        let button = MainButton()
        button.title = TextLiteral.onboardingProfileViewControllerDoneButtonText
        button.isDisabled = true
        return button
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didTapImage()
        setButtonAction()
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.componentPadding)
        }
        
        view.addSubview(onboardingProfileGroupCollectionView)
        onboardingProfileGroupCollectionView.snp.makeConstraints {
            $0.top.equalTo(collectionViewLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.bottom.equalTo(profileDoneButton.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - functions
    
    private func setButtonAction() {
        let didTapDoneAction = UIAction { [weak self] _ in
            self?.didTapDoneButton()
            self?.petchMyInfo()
        }
        self.profileDoneButton.addAction(didTapDoneAction, for: .touchUpInside)
    }
    
    func didTapDoneButton() {
        let groupMainViewController = GroupMainViewController()
        if let name = userName {
            groupMainViewController.setUserName(name: name)
        }
        groupMainViewController.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(groupMainViewController, animated: true)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    func didTapImage() {
        onboardingProfileGroupCollectionView.didTappedImage = { [weak self] image in
            self?.selectedProfileImageView.image = image
            if let imageString = image.accessibilityIdentifier {
                self?.userImage = imageString.profileAssetStringToString(imageAssetString: imageString)
            }
            guard let selectedImage = self?.selectedProfileImageView.image else { return }
            if selectedImage != ImageLiterals.profileNone {
                self?.profileDoneButton.isDisabled = false
            }
        }
    }
    
    func setUserName(name: String) {
        userName = name
    }
    
    private func petchMyInfo() {
        guard let name = userName,
              let image = userImage else { return }
        let memberPatchRequest = MemberPatchRequest(memberName: name, profilePath: image, statusMessage: String())
        self.petchMemberInfoFromServer(body: memberPatchRequest) { [weak self] response in
            guard self != nil else { return }
        }
    }
}

// MARK: - network

extension OnboardingProfileViewController {
    private func petchMemberInfoFromServer(body: MemberPatchRequest, completion: @escaping (MemberPatchResponse) -> Void) {
        NetworkService.shared.members.petchMemberInfo(body: body) { result in
            switch result {
            case .success(let response):
                guard let data = response as? MemberPatchResponse else { return }
                completion(data)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("error")
            }
        }
    }
}
