//
//  StatisticsView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

enum StatisticsSectionType: CaseIterable {
    case rankSection
    case memberHouseWorkSection
}

final class StatisticsView: BaseUIView {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.contentInsetsReference = .none
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let section = StatisticsSectionType.allCases[sectionIndex]
            switch section {
            case .rankSection:
                return self?.getLayoutRankSection()
            case .memberHouseWorkSection:
                return self?.getLayoutMemberHouseWorkSection()
            }
        }, configuration: config)
        
        return layout
    }
    
    private func getLayoutRankSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
         let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(75), heightDimension: .absolute(140))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         
         let section =  NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 22, leading: 24, bottom: 16, trailing: 24)
         section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 8
         
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
         let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
         section.boundarySupplementaryItems = [headerSupplementary]
         
         return section
    }
    
    private func getLayoutMemberHouseWorkSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         group.interItemSpacing = .fixed(100)
         
         let section =  NSCollectionLayoutSection(group: group)
         section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 24, bottom: 18, trailing: 24)
        section.interGroupSpacing = 16
         
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(85))
         let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
         section.boundarySupplementaryItems = [headerSupplementary]
         
         return section
    }
    
    override func render() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.bottom.horizontalEdges.equalTo((self.safeAreaLayoutGuide))
        }
    }
}
