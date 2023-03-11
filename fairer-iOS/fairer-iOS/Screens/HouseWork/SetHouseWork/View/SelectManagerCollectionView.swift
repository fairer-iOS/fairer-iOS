//
//  SelectManagerCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/22.
//

import UIKit

import SnapKit

final class SelectManagerCollectionView: BaseUIView {
    
    var selectedIndex: Int? = 0
    // FIXME: - SetHouseWorkVC에서 전체 멤버리스트 받아오기
    var totalMemberList: [MemberResponse] = []
    var selectedManagerList: [String] = [] {
        didSet { collectionView.reloadData() }
    }
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 24
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 327
        static let cellHeight: CGFloat = 40.6
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
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectManagerCollectionViewCell.self, forCellWithReuseIdentifier: SelectManagerCollectionViewCell.className)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
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

extension SelectManagerCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        if let memberName = totalMemberList[indexPath.item].memberName {
            selectedManagerList.append(memberName)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if !selectedManagerList.isEmpty {
            selectedManagerList.removeAll(where: { $0 == totalMemberList[indexPath.item].memberName})
        }
    }
}

extension SelectManagerCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalMemberList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectManagerCollectionViewCell.className, for: indexPath) as? SelectManagerCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        if let memberName = totalMemberList[indexPath.item].memberName {
            if selectedManagerList.contains(memberName) {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
        }
        
        cell.profileName.setTextWithLineHeight(text: totalMemberList[indexPath.item].memberName, lineHeight: 26)
        
        
        return cell
    }
}
