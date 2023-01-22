//
//  SetHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let setHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let setHouseWorkCollectionView = SetHouseWorkCollectionView()
    private let getManagerView = GetManagerView()
    private let selectManagerView = SelectManagerView()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(setHouseWorkCalendarView)
        setHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        view.addSubview(setHouseWorkCollectionView)
        setHouseWorkCollectionView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCalendarView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        view.addSubview(getManagerView)
        getManagerView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        view.addSubview(selectManagerView)
        selectManagerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(341)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
