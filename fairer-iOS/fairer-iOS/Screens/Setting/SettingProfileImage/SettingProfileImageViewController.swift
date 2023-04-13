//
//  SettingProfileImageViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/17.
//

import UIKit

class SettingProfileImageViewController: OnboardingProfileViewController {

    // FIXME: - api 연결로 대체
    private let lastProfileImage = ImageLiterals.profileBlue3
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImage()
    }
    
    // MARK: - func
    
    private func setupProfileImage() {
        super.selectedProfileImageView.image = lastProfileImage
    }
    
    override func didTapDoneButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
