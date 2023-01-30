//
//  RepeatCycleCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/27.
//

import UIKit

import SnapKit

final class RepeatCycleCollectionView: BaseUIView {
    
    var selectedIndex: Int?
    var selectedHouseWorkIndex: Int = 0 {
        didSet {
            selectedDaysOfWeek = HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatPattern ?? []
        }
    }
    private let daysOfWeek: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    var selectedDaysOfWeek: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var didSelectDaysOfWeek: (([String]) -> ())?
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 31.5
        static let collectionVerticalSpacing: CGFloat = 0
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
    lazy var collectionView: UICollectionView = {
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
        selectedIndex = indexPath.item
        selectedDaysOfWeek.append(daysOfWeek[indexPath.item])
        didSelectDaysOfWeek?(selectedDaysOfWeek)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedDaysOfWeek.removeAll(where: { $0 == daysOfWeek[indexPath.item]})
        didSelectDaysOfWeek?(selectedDaysOfWeek)
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
        
        if let houseWorkPattern = HouseWork.mockHouseWork[selectedHouseWorkIndex].repeatPattern {
            if houseWorkPattern.contains(daysOfWeek[indexPath.item]) {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            }
        }
        
        cell.weekOfDayLabel.text = daysOfWeek[indexPath.item]
        
        return cell
    }
}
