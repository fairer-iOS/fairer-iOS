//
//  BaseTableViewCell.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    func render() {
        // Override Layout
    }
    
    func configUI() {
        // Override ConfigUI
    }
}
