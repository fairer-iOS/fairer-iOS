//
//  SettingProfileViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/14.
//

import UIKit

import SnapKit

final class SettingProfileViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    
    // MARK: - life cycle
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
