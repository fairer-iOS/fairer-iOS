//
//  HomeGroupCollectionView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeGroupCollectionView: BaseUIView {
    
    
    var userList: [MemberResponse] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var selectedIndex = 0
    lazy var selectedMemberName = ""
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 17
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 55
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
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
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
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension HomeGroupCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell  = collectionView.cellForItem(at: indexPath) as! HomeGroupCollectionViewCell
        self.selectedIndex = indexPath.row
        selectedCell.isSelected = true
        self.selectedMemberName = userList[indexPath.row].memberName ?? String()
        // MARK: - fix me : 본인 선택 시 다시
        NotificationCenter.default.post(name: Notification.Name.member, object: nil, userInfo: [NotificationKey.member: userList[indexPath.row].memberId ?? Int()])
    }
}

extension HomeGroupCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGroupCollectionViewCell.className, for: indexPath) as? HomeGroupCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        guard let memberName = userList[indexPath.item].memberName,
              let memberImage = userList[indexPath.item].profilePath else { return UICollectionViewCell() }
        cell.titleImage.load(from: memberImage)
        cell.titleLabel.text = memberName
        if cell.isSelected == true { cell.onSelected() }
        else { cell.onDeselected() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if selectedIndex == indexPath.item {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
    }
}
