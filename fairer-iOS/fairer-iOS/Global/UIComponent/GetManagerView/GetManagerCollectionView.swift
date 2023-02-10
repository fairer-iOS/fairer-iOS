//
//  GetManagerCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class GetManagerCollectionView: BaseUIView {
    
    // FIXME: - 담당자 리스트 받아오기
    var selectedMemberList: [String] = ["고가혜"] {
        didSet { collectionView.reloadData() }
    }
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 0
        static let collectionVerticalSpacing: CGFloat = 8
        static let cellWidth: CGFloat = 48
        static let cellHeight: CGFloat = 70
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
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cell: MemberCollectionViewCell.self,
                                forCellWithReuseIdentifier: MemberCollectionViewCell.className)
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

extension GetManagerCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedMemberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.className, for: indexPath) as? MemberCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.profileLabel.setTextWithLineHeight(text: selectedMemberList[indexPath.row], lineHeight: 18)

        return cell
    }
}
