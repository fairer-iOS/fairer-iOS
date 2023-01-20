//
//  SetHouseWorkCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkCollectionView: BaseUIView {
    
    var selectedIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // FIXME: - SelectHouseWorkVC에서 선택한 집안일 목록 연결
    private var selectedDetailHouseWork = ["창 청소", "거실 청소", "물건 정리정돈", "환기 시키기", "빨래 돌리기", "빨래 개기", "세탁기 청소"]
    
    lazy var isSelectedDetailHouseWork = [selectedDetailHouseWork[selectedIndex]]
    
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
    private lazy var collectionView: UICollectionView = {
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
        isSelectedDetailHouseWork.append(selectedDetailHouseWork[selectedIndex])
    }
}

extension SetHouseWorkCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedDetailHouseWork.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SetHouseWorkCollectionViewCell.className, for: indexPath) as? SetHouseWorkCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        if isSelectedDetailHouseWork.contains(selectedDetailHouseWork[indexPath.item]) {
            cell.houseWorkLabel.textColor = .blue
        }
        
        if indexPath.item == selectedIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        
        cell.houseWorkLabel.text = selectedDetailHouseWork[indexPath.row]
        
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(didTappedDeleteButton(sender:)), for: .touchUpInside)
        
        return cell
    }
}

extension SetHouseWorkCollectionView {
    @objc func didTappedDeleteButton(sender : UIButton) {
        collectionView.deleteItems(at: [IndexPath.init(item: sender.tag, section: 0)])
        isSelectedDetailHouseWork.removeAll(where: { $0 == selectedDetailHouseWork[sender.tag] })
        selectedDetailHouseWork.remove(at: sender.tag)
                
        if selectedDetailHouseWork.isEmpty {
            // FIXME: - 이전 페이지로 이동
        } else if selectedDetailHouseWork.count == 1 {
            selectedIndex = 0
        }
        
        if selectedIndex > sender.tag {
            selectedIndex -= 1
        }
    }
}
