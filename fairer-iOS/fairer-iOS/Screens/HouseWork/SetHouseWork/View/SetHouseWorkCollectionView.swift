//
//  SetHouseWorkCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkCollectionView: BaseUIView {
    
    var totalHouseWorks: [HouseWorksRequest] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var didTappedHouseWork: ((Int) -> ())?
    var didDeleteHouseWork: ((Int) -> ())?
    
    var selectedIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var isSelectedDetailHouseWork = [totalHouseWorks[0].houseWorkName]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 24
        static let collectionVerticalSpacing: CGFloat = 16
        static let cellWidth: CGFloat = 101
        static let cellHeight: CGFloat = 102
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
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SetHouseWorkCollectionViewCell.self, forCellWithReuseIdentifier: SetHouseWorkCollectionViewCell.className)
        collectionView.showsHorizontalScrollIndicator = false
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

extension SetHouseWorkCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        isSelectedDetailHouseWork.append(totalHouseWorks[selectedIndex].houseWorkName)
        didTappedHouseWork?(selectedIndex)
    }
}

extension SetHouseWorkCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalHouseWorks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SetHouseWorkCollectionViewCell.className, for: indexPath) as? SetHouseWorkCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        if isSelectedDetailHouseWork.contains(totalHouseWorks[indexPath.item].houseWorkName) {
            cell.houseWorkLabel.textColor = .blue
        }
        
        if indexPath.item == selectedIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        cell.houseWorkLabel.text = totalHouseWorks[indexPath.row].houseWorkName
        cell.timeLabel.setTextWithLineHeight(text: totalHouseWorks[indexPath.row].scheduledTime, lineHeight: 18)

        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(didTappedDeleteButton(sender:)), for: .touchUpInside)
        
        return cell
    }
}

extension SetHouseWorkCollectionView {
    @objc func didTappedDeleteButton(sender : UIButton) {
        collectionView.deleteItems(at: [IndexPath.init(item: sender.tag, section: 0)])
        isSelectedDetailHouseWork.removeAll(where: { $0 == totalHouseWorks[sender.tag].houseWorkName })
        didDeleteHouseWork?(sender.tag)
        
        if totalHouseWorks.isEmpty {
            // FIXME: - 이전 페이지로 이동
        }
        
        if selectedIndex > sender.tag || (selectedIndex == sender.tag && sender.tag == totalHouseWorks.endIndex) {
            selectedIndex -= 1
        } else if sender.tag == selectedIndex {
            isSelectedDetailHouseWork.append(totalHouseWorks[sender.tag].houseWorkName)
        }
    }
}
