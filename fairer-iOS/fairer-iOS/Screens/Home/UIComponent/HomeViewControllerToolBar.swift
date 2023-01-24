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
        self.addSubview(affairView)
        affairView.addSubviews(affairLabel,plusImage)
        
        affairView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.centerY.equalToSuperview()
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
