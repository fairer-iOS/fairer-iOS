//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

class SettingHomeRuleViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)

    // MARK: - life cycle
     
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
}
