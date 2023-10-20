//
//  HomeViewControllerToolBar.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeViewControllerToolBar: UIView {
    
    // MARK: - property
    
    private let contentView = UIView()
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray300.withAlphaComponent(0.2)
        return view
    }()
    private let affairView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray200.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        return view
    }()
    private let affairLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeViewAddWorkLabel
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let plusImage = UIImageView(image: ImageLiterals.plusWorkButton)
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        self.addSubview(contentView)
        contentView.addSubviews(borderView, affairView)
        affairView.addSubviews(affairLabel, plusImage)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        borderView.snp.makeConstraints {
            $0.width.top.equalToSuperview()
            $0.height.equalTo(0.7)
        }
        
        affairView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.top.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }

        affairLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        plusImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
