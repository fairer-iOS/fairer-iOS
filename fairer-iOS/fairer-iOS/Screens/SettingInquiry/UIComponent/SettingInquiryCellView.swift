//
//  SettingInquiryCellView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/20.
//

import UIKit

import SnapKit

final class SettingInquiryCellView: UIView {
    
    // MARK: - property
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.text = "테스트임"
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private lazy var cellButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = .caption1
        button.setUnderline()
        let action = UIAction { [weak self] _ in
            self?.didTappedCellButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) { nil }
    
    private func render() {
        self.addSubview(cellLabel)
        cellLabel.snp.makeConstraints {
            $0.centerY.leading.equalToSuperview()
        }
        
        self.addSubview(cellButton)
        cellButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
        }
        
        self.addSubview(cellDivider)
        cellDivider.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    // MARK: - func
    
    private func didTappedCellButton() {
        print("테스트: 잘됨")
    }
}
