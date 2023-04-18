//
//  NoNetworkView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/04/16.
//

import UIKit

import SnapKit

final class NoNetworkView: BaseUIView {
    
    private let networkfailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.networkError
        return imageView
    }()
    
    override func configUI() {
        self.backgroundColor = .white
    }
    
    override func render() {
        self.addSubview(networkfailImageView)
        networkfailImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
