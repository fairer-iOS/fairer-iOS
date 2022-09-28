//
//  SelectHouseWorkSpaceCollectionView.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class SelectHouseWorkSpaceCollectionView: BaseUIView {
    
    // FIXME
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 0
        static let collectionVerticalSpacing: CGFloat = 0
        static let cellWidth: CGFloat = 105
        static let cellHeight: CGFloat = 109
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
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SelectHouseWorkSpaceCollectionViewCell.self, forCellWithReuseIdentifier: SelectHouseWorkSpaceCollectionViewCell.className)
        return collectionView
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(collectionView)
        //FIXME
        collectionView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - extension

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDelegate {}

extension SelectHouseWorkSpaceCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Space.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectHouseWorkSpaceCollectionViewCell.className, for: indexPath) as? SelectHouseWorkSpaceCollectionViewCell else {
            assert(false, "Wrong Cell")
            return UICollectionViewCell()
        }
        
        cell.index = indexPath.row
//        cell.spaceImageView.image = Space.allCases[indexPath.row].normalImage
        cell.spaceImageView.image = ImageLiterals.imgEntrance
        cell.spaceNameLabel.text = Space.allCases[indexPath.row].rawValue
        
        return cell
    }
}

enum Space: String, CaseIterable {
    case entrance = "현관"
    case livingRoom = "거실"
    case bathroom = "화장실"
    case outside = "외부"
    case room = "방"
    case kitchen = "부엌"
    
    var normalImage: UIImage {
        switch self {
        case .entrance:
            return ImageLiterals.imgEntrance
        case .livingRoom:
            return ImageLiterals.imgLivingRoom
        case .bathroom:
            return ImageLiterals.imgBathroom
        case .outside:
            return ImageLiterals.imgOutside
        case .room:
            return ImageLiterals.imgRoom
        case .kitchen:
            return ImageLiterals.imgKitchen
        }
    }
    
    var selecteImage: UIImage {
        switch self {
        case .entrance:
            return ImageLiterals.imgSelectedEntrance
        case .livingRoom:
            return ImageLiterals.imgSelectedLivingRoom
        case .bathroom:
            return ImageLiterals.imgSelectedBathroom
        case .outside:
            return ImageLiterals.imgSelectedOutside
        case .room:
            return ImageLiterals.imgSelectedRoom
        case .kitchen:
            return ImageLiterals.imgKitchen //FIXME
        }
    }
}
