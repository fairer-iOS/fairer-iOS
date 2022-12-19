//
//  SettingAlarmViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

import SnapKit

final class SettingAlarmViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingAlarmTableView = UITableView()

    // MARK: - life cycle
    
    override func render() {
        view.addSubview(settingAlarmTableView)
        settingAlarmTableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
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
