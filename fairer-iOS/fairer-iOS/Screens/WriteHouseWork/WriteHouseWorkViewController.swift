//
//  WriteHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/02/01.
//

import UIKit

import SnapKit

final class WriteHouseWorkViewController: BaseViewController {
    
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    // FIXME: - PR 머지되면 Calendar View Global 로
    private let writeHouseWorkCalendarView = SetHouseWorkCalendarView()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubviews(writeHouseWorkCalendarView)
        writeHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
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
