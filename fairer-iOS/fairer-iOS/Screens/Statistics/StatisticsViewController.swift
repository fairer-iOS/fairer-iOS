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
        mainView.collectionView.register(cell: MemberHouseWorkSectionCollectionViewCell.self)
        mainView.collectionView.register(RankSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "RankSectionHeaderReusableView")
        mainView.collectionView.register(MemberHouseWorkSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MemberHouseWorkSectionHeaderReusableView")
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
                cell.setMemberRankTypeUI(.first)
            } else if indexPath.row == 1 {
                cell.setRankerViewisHidden(first: true, second: false, third: true)
                cell.setMemberRankTypeUI(.second)
            } else if indexPath.row == 2 {
                cell.setRankerViewisHidden(first: true, second: true, third: false)
                cell.setMemberRankTypeUI(.third)
            } else {
                cell.setRankerViewisHidden(first: true, second: true, third: true)
                cell.setMemberRankTypeUI(.none)
            }
            return cell
        case .memberHouseWorkSection:
            let cell: MemberHouseWorkSectionCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            switch StatisticsSectionType.allCases[indexPath.section] {
            case .rankSection:
                let header: RankSectionHeaderReusableView = collectionView.dequeueHeaderView(forIndexPath: indexPath)
                return header
            case .memberHouseWorkSection:
                let header: MemberHouseWorkSectionHeaderReusableView = collectionView.dequeueHeaderView(forIndexPath: indexPath)
                return header
            }
        default:
            return UICollectionReusableView()
        }
    }
}
