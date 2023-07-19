//
//  HomeGroupCollectionViewCell.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeGroupCollectionViewCell: BaseCollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.onSelected()
                self.bringSubviewToFront(titleImage)
            }else {
                self.onDeselected()
            }
        }
    }
    
    // MARK: - property
    
    let titleImage = UIImageView()
    let checkCircleView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.blue.cgColor
        view.backgroundColor = .clear
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .caption1
        label.textColor = .gray800
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubviews(titleImage,titleLabel)
        titleImage.addSubview(checkCircleView)
        titleImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(47)
        }
        checkCircleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.center.equalToSuperview()
            $0.width.height.equalTo(48)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(titleImage.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func onSelected(){
        checkCircleView.isHidden = false
        self.bringSubviewToFront(titleImage)
    }
    
    func onDeselected(){
        checkCircleView.isHidden = true
    }
}
