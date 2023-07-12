//
//  SelectHouseWorkSpaceCollectionView.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkSpaceCollectionView: BaseUIView {
    
    var didTappedSpace: ((Space) -> ())?
    var showDisableAlert: ((Bool) -> ())?
    var didChangeSpaceWithHouseWork: Bool = false
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 24
        static let collectionVerticalSpacing: CGFloat = 12
        static let cellWidth: CGFloat = 102
        static let cellHeight: CGFloat = 107
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
    lazy var collectionView: UICollectionView = {
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
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        showDisableAlert?(didChangeSpaceWithHouseWork)
        return !didChangeSpaceWithHouseWork
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTappedSpace?(Space.allCases[indexPath.item])
    }
}

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Space.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectHouseWorkSpaceCollectionViewCell.className, for: indexPath) as? SelectHouseWorkSpaceCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.index = indexPath.row
        cell.spaceImageView.image = Space.allCases[indexPath.row].normalImage
        cell.spaceNameLabel.text = Space.allCases[indexPath.row].rawValue
        
        return cell
    }
}
