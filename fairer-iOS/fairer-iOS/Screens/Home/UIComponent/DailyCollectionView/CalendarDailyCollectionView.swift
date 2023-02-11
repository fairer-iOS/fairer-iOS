//
//  CalendarDailyTableView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

struct dummyWorkCard {
    let work = ["바닥 청소","설거지","빨래","바닥 청소","설거지","빨래","설거지"]
    let time = ["오전 9:30","오후 8:00","오전 11:00","오전 9:30","오후 8:00","오전 11:00","오전 11:00"]
    let room = ["방","부엌","거실","방","부엌","방","부엌"]
    let status = [ WorkState.overdue,WorkState.overdue,WorkState.notFinished,WorkState.finished,WorkState.finished,WorkState.finished,WorkState.finished]
}

final class CalendarDailyCollectionView: BaseUIView  {
    
    private var cellNum = 0
    var changeHeightClosure: ((Int)->())?
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
    
    // MARK: - TODO.API
    
    private let dummy = dummyWorkCard()
    
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
        collectionView.register(cell: CalendarDailyCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDailyCollectionViewCell.className)
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

// MARK: - Extension

extension CalendarDailyCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}
extension CalendarDailyCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            cellNum = cellNum + 3
            return 3
        }else {
            cellNum = cellNum + 4
            changeHeightClosure?(cellNum)
            cellNum = 0
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarDailyCollectionViewCell.className, for: indexPath) as? CalendarDailyCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        cell.workLabel.text = dummy.work[indexPath.item]
        cell.time.text = dummy.time[indexPath.item]
        cell.room.text = dummy.room[indexPath.item]
        switch dummy.status[indexPath.item] {
        case .finished :
            cell.backgroundColor = .positive10
        case .notFinished :
            cell.backgroundColor = .white
        case .overdue :
            cell.backgroundColor = .negative0
            cell.layer.borderColor = UIColor.negative10.cgColor
            cell.setErrorImageView()
        }
        return cell
    }
}
