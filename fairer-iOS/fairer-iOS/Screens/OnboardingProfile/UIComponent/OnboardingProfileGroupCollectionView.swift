//
//  HomeGroupCollectionView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class OnboardingProfileGroupCollectionView: BaseUIView {
    let profileList: [UIImage] = [ImageLiterals.profileBlue3, ImageLiterals.profileBlue4, ImageLiterals.profileOrange1, ImageLiterals.profilePink1, ImageLiterals.profilePink3, ImageLiterals.profileOrange2, ImageLiterals.profileYellow2, ImageLiterals.profileIndigo3, ImageLiterals.profilePurple1, ImageLiterals.profilePurple2, ImageLiterals.profilePurple3, ImageLiterals.profileGreen1, ImageLiterals.profileYellow1, ImageLiterals.profileGreen3, ImageLiterals.profileLightBlue1, ImageLiterals.profileLightBlue2]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 33
        static let collectionVerticalSpacing: CGFloat = 16
        static let cellSize: CGFloat = UIScreen.main.bounds.width * 0.15
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private lazy var selectedProfileName = ImageLiterals.profileNone
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellSize, height: Size.cellSize)
        flowLayout.minimumLineSpacing = 24
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: OnboardingProfileGroupCollectionViewCell.self,
                                forCellWithReuseIdentifier: OnboardingProfileGroupCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - functions
    
    private func getImageIndex(by name: UIImage) -> Int {
        guard let index = profileList.firstIndex(of: name) else {
            return 1
        }
        return index
    }
}

extension OnboardingProfileGroupCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProfileName = profileList[indexPath.item]
    }
}

extension OnboardingProfileGroupCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingProfileGroupCollectionViewCell.className, for: indexPath) as? OnboardingProfileGroupCollectionViewCell else {
            assert(false, "Wrong Cell")
            
            return UICollectionViewCell()
        }
        
        let selectedImageIndex = getImageIndex(by: selectedProfileName)
        if indexPath.item == selectedImageIndex {
            cell.isSelected = true
        }
        
        cell.profileImage.image = profileList[indexPath.item]
        return cell
    }
}
