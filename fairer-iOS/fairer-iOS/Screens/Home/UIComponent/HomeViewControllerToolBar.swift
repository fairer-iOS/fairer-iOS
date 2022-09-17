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
        label.text = "집안일을 추가해 보세요!"
        label.font = .caption1
        label.textColor = .gray400
        return label
    }()
    private let plusImage = UIImageView(image: UIImage(systemName: "plus"))
    
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
        affairView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(44)
        }
        affairView.addSubview(affairLabel)
        affairLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        affairView.addSubview(plusImage)
        plusImage.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
