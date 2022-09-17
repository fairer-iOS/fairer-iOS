//
//  HomeGroupCollectionView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeGroupCollectionView: BaseUIView {
    let userList = ["고가혜", "권진혁", "최지혜", "신동빈", "김수연"]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 24
        static let collectionVerticalSpacing: CGFloat = 10
        static let cellWidth: CGFloat = 48
        static let cellHeight: CGFloat = 68
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: HomeGroupCollectionViewCell.self,
            forCellWithReuseIdentifier: HomeGroupCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension HomeGroupCollectionView: UICollectionViewDelegate { }

extension HomeGroupCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGroupCollectionViewCell.className, for: indexPath) as? HomeGroupCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.titleLable.text = userList[indexPath.item]
        
        return cell
    }
}
