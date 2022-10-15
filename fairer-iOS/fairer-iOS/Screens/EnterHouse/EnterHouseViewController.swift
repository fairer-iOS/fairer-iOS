//
//  EnterHouseViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/10/15.
//

import UIKit

import SnapKit

final class EnterHouseViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton()

    // MARK: - lifecycle
    
    override func render() {
        
    }
    
    // MARK: - functions
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
