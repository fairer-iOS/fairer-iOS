//
//  RepeatCycleCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/27.
//

import UIKit

import SnapKit

final class RepeatCycleCollectionView: BaseUIView {
    
    private let daysOfWeek: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    var selectedDaysOfWeek: [String] = []
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 31.5
        static let collectionVerticalSpacing: CGFloat = 8
        static let cellLength: CGFloat = 40
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
        flowLayout.itemSize = CGSize(width: Size.cellLength, height: Size.cellLength)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 5.33
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RepeatCycleCollectionViewCell.self, forCellWithReuseIdentifier: RepeatCycleCollectionViewCell.className)
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

extension RepeatCycleCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDaysOfWeek.append(daysOfWeek[indexPath.item])
        print(selectedDaysOfWeek)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedDaysOfWeek.removeAll(where: { $0 == daysOfWeek[indexPath.item]})
        print(selectedDaysOfWeek)

    }
}

extension RepeatCycleCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RepeatCycleCollectionViewCell.className, for: indexPath) as? RepeatCycleCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.weekOfDayLabel.text = daysOfWeek[indexPath.item]
        
        return cell
    }
}
