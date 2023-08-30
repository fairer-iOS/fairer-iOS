//
//  BaseCollectionView.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    func setHierarchy() {
        
    }
    
    func render() {
        // Override Layout
    }
    
    func configUI() {
        // View Configuration
    }
}
