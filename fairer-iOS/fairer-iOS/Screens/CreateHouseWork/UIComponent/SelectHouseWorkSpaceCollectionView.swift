//
//  SelectHouseWorkSpaceCollectionView.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkSpaceCollectionView: BaseUIView {
    
    // FIXME - 더미 삭제
    let spaceArray = ["현관", "거실", "화장실", "외부", "방", "부엌"]
    // FIXME
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 3
        static let collectionVerticalSpacing: CGFloat = 3
        static let cellWidth: CGFloat = 105
        static let cellHeight: CGFloat = 109
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    // MARK: - property

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectHouseWorkSpaceCollectionViewCell.self, forCellWithReuseIdentifier: SelectHouseWorkSpaceCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(collectionView)
        //FIXME
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - extension

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDelegate {}

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectHouseWorkSpaceCollectionViewCell.className, for: indexPath) as? SelectHouseWorkSpaceCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        //FIXME
        cell.backgroundColor = .blue
        cell.spaceNameLabel.text = spaceArray[indexPath.row]
        return cell
    }
    
    
}
