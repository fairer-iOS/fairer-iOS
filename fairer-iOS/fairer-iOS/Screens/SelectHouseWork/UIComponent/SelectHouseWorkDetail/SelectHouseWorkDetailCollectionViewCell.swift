//
//  SelectHouseWorkDetailCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/10.
//

import UIKit

import SnapKit

final class SelectHouseWorkDetailCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet { setupAttribute() }
    }
    
    // MARK: - property
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray100.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    let cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .body2
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(cellBackgroundView)
        cellBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cellBackgroundView.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - func
    
    private func setupAttribute() {
        if isSelected {
            
        } else {
            
        }
    }
}
