//
//  HouseMemberCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/31.
//

import UIKit

import SnapKit

final class HouseMemberCollectionView: BaseUIView, UICollectionViewDelegate {
    
    // FIXME: - 추후 api 연결하면 삭제할 내용
    let profileNameList: [String] = ["진저", "이드", "호야", "케미", "메리"]
    let profileImageList: [UIImage] = [ImageLiterals.profileBlue3, ImageLiterals.profileBlue4, ImageLiterals.profileOrange1, ImageLiterals.profilePink1, ImageLiterals.profilePink3]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 29
        static let collectionVerticalSpacing: CGFloat = 16
        static let cellSize: CGFloat = 56
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellSize, height: Size.cellSize)
        flowLayout.minimumLineSpacing = 40
        flowLayout.minimumInteritemSpacing = 31
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: HouseMemberCollectionViewCell.self,
                                forCellWithReuseIdentifier: HouseMemberCollectionViewCell.className)
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

extension HouseMemberCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileNameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseMemberCollectionViewCell.className, for: indexPath) as? HouseMemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.profileImage.image = profileImageList[indexPath.item]
        cell.profileName.setTextWithLineHeight(text: profileNameList[indexPath.item], lineHeight: 26)
        return cell
    }
}

