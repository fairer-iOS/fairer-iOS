//
//  SplashView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/22.
//

import UIKit

import SnapKit

final class SplashViewController: BaseViewController {
    
    // MARK: - property

    private let splashLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.imgLogoSplash
        return imageView
    }()
    
    // MARK: - lifecycle
    
    override func render() {
        view.addSubview(splashLogo)
        splashLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
}
