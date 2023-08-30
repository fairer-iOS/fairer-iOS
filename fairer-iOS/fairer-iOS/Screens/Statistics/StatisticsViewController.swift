//
//  StatisticsViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class StatisticsViewController: BaseViewController {
    
    private let mainView = StatisticsView()
    
    override func loadView() {
        self.view = mainView
        view.backgroundColor = .blueDark
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(cell: RankCollectionViewCell.self)
        mainView.collectionView.register(RankSectionFooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "RankSectionFooterReusableView")
        mainView.collectionView.register(RankSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RankSectionHeaderReusableView")
    }
}

extension StatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StatisticsSectionType.allCases.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch  StatisticsSectionType.allCases[section] {
        case .rankSection:
            return 20
        case .memberHouseWorkSection:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch StatisticsSectionType.allCases[indexPath.section] {
        case .rankSection:
            let cell: RankCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            
            if indexPath.row == 0  {
                cell.setRankerViewisHidden(first: false, second: true, third: true)
            } else if indexPath.row == 1 {
                cell.setRankerViewisHidden(first: true, second: false, third: true)
            } else if indexPath.row == 2 {
                cell.setRankerViewisHidden(first: true, second: true, third: false)
            } else {
                cell.setRankerViewisHidden(first: true, second: true, third: true)
            }
            return cell
        case .memberHouseWorkSection:
            let cell: RankCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header: RankSectionHeaderReusableView = collectionView.dequeueHeaderView(forIndexPath: indexPath)
            return header
        case UICollectionView.elementKindSectionFooter:
            let section = StatisticsSectionType.allCases[indexPath.section]
            if section == .rankSection {
                let footer: RankSectionFooterReusableView = collectionView.dequeueFooterView(forIndexPath: indexPath)
                return footer
            } else {
                return UICollectionReusableView()
            }
        default:
            return UICollectionReusableView()
        }
    }
}
