//
//  CalendarDailyWorkEndCollectionView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/14.
//

import UIKit

import SnapKit

struct dummyWorkEndCard {
    let work = ["바닥 청소","설거지"]
    let time = ["오후 7:30","오전 8:00"]
    let room = ["거실","부엌"]
}

class CalendarDailyWorkEndCollectionView: BaseUIView  {
    
    // dummuy data
    let dummy = dummyWorkEndCard()
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 0
        static let collectionVerticalSpacing: CGFloat = 8
        static let cellWidth: CGFloat = 327
        static let cellHeight: CGFloat = 94
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
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(cell: CalendarDailyWorkEndCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDailyWorkEndCollectionViewCell.className)
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

extension CalendarDailyWorkEndCollectionView: UICollectionViewDelegate {}

extension CalendarDailyWorkEndCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDailyWorkEndCollectionViewCell.className, for: indexPath) as? CalendarDailyWorkEndCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        // 일단 dummy binding
        cell.workLabel.text = dummy.work[indexPath.item]
        cell.time.text = dummy.time[indexPath.item]
        cell.room.text = dummy.room[indexPath.item]
        
        return cell
    }
    
    
}
