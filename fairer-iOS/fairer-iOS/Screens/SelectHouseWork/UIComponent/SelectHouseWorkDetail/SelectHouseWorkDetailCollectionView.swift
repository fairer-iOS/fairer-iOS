//
//  SelectHouseWorkDetailCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/10.
//

import UIKit

import SnapKit

final class SelectHouseWorkDetailCollectionView: BaseUIView {
    
    var space: Space = .entrance {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 24
        static let collectionVerticalSpacing: CGFloat = 8
        static let cellWidth: CGFloat = 102.3
        static let cellHeight: CGFloat = 64
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
        collectionView.register(SelectHouseWorkDetailCollectionViewCell.self, forCellWithReuseIdentifier: SelectHouseWorkDetailCollectionViewCell.className)
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

// MARK: - extension

extension SelectHouseWorkDetailCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // FIXME: - api 연결할 때 공간 전달
        print(space.houseWorkDetailList[indexPath.item])
    }
}

extension SelectHouseWorkDetailCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return space.houseWorkDetailList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectHouseWorkDetailCollectionViewCell.className, for: indexPath) as? SelectHouseWorkDetailCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }

        cell.cellLabel.text = space.houseWorkDetailList[indexPath.item]
        
        return cell
    }
}
