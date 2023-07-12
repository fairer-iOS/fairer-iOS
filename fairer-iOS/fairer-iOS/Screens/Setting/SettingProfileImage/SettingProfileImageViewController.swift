//
//  SettingProfileImageViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/17.
//

import UIKit

class SettingProfileImageViewController: OnboardingProfileViewController {
    
    private var firstProfileImage: String?
    private var firstName: String?
    private var firstStatus: String?
    private var lastProfileImage: String?
    
    var profileImageChangeClosure: ((String) -> Void)?
    var settingProfileViewDidPop: ((Bool) -> Void)?
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - func
    
    override func didTapDoneButton() {
        if let lastProfileImage = lastProfileImage {
            profileImageChangeClosure?(lastProfileImage)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        settingProfileViewDidPop?(true)
    }
    
    override func didTapImage() {
        onboardingProfileGroupCollectionView.didTappedImage = { [weak self] image in
            self?.selectedProfileImageView.image = image
            guard let selectedImage = self?.selectedProfileImageView.image else { return }
            if selectedImage != ImageLiterals.profileNone {
                self?.profileDoneButton.isDisabled = false
                if let imageString = image.accessibilityIdentifier {
                    self?.lastProfileImage = imageString.profileAssetStringToString(imageAssetString: imageString)
                }
            }
        }
    }
    
    func setupProfile(image: String, name: String, status: String) {
        super.selectedProfileImageView.load(from: image)
        self.firstProfileImage = image
        self.firstStatus = status
        self.firstName = name
        self.lastProfileImage = image
    }
}
