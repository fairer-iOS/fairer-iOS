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
    
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - func
    
    override func didTapDoneButton() {
        petchMyInfo()
        self.navigationController?.popViewController(animated: true)
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
    
    private func petchMyInfo() {
        let memberPatchRequest = MemberPatchRequest(memberName: firstName, profilePath: lastProfileImage, statusMessage: firstStatus)
        self.petchMemberInfoFromServer(body: memberPatchRequest) { [weak self] response in
            guard self != nil else { return }
        }
    }
}

extension SettingProfileImageViewController {
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
