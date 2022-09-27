//
//  OnboardingProfileGroupCollectionView.swift
//  fairer-iOS
//
//  Created by by 김유나 on 2022/09/19.
//

import UIKit

import SnapKit

final class OnboardingProfileGroupCollectionView: BaseUIView {
    var didTappedImage: ((UIImage) -> ())?
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
    private lazy var selectedProfileName = ImageLiterals.profileNone

    // MARK: - property
    
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
            $0.edges.equalToSuperview()
        }
    }
}

extension OnboardingProfileGroupCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedProfileName = ImageLiterals.profileList[indexPath.item]
        didTappedImage?(selectedProfileName)
    }
}

extension OnboardingProfileGroupCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageLiterals.profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingProfileGroupCollectionViewCell.className, for: indexPath) as? OnboardingProfileGroupCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.isSelected = true
        cell.profileImage.image = ImageLiterals.profileList[indexPath.item]
        return cell
    }
}
