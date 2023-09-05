//
//  EmojiCollectionView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/08/30.
//

import UIKit

import SnapKit

final class EmojiCollectionView: BaseUIView {
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 7
        static let collectionVerticalSpacing: CGFloat = 7
        static let cellLength: CGFloat = UIScreen.main.bounds.width * 0.1
        static let collectionInsets = UIEdgeInsets(
            top: collectionVerticalSpacing,
            left: collectionHorizontalSpacing,
            bottom: collectionVerticalSpacing,
            right: collectionHorizontalSpacing)
    }
    var selectedEmojiList = [Int:Bool]()
    
    // MARK: - property

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = Size.collectionInsets
        flowLayout.itemSize = CGSize(width: Size.cellLength, height: Size.cellLength)
        return flowLayout
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(EmojiCollectionViewCell.self, forCellWithReuseIdentifier: EmojiCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(backView)
        backView.addSubview(collectionView)
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - extension

extension EmojiCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emojiNum = ImageLiterals.emojiList.count
        selectedEmojiList = Dictionary(uniqueKeysWithValues: (0..<emojiNum).map{($0, false)})
        return emojiNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.className, for: indexPath) as? EmojiCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.emojiImageView.image = ImageLiterals.emojiList[indexPath.item]
        
        let action = UIAction { [weak self] _ in
            self?.didTappedEmoji(indexPath.item)
            cell.isSelected.toggle()
        }
        cell.backView.addAction(action, for: .touchUpInside)
        
        return cell
    }
    
    private func didTappedEmoji(_ index: Int) {
        selectedEmojiList[index]?.toggle()
    }
}
