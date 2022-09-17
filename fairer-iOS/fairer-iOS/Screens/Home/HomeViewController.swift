//
//  HomeViewController.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/17.
//

import UIKit

import SnapKit

final class HomeViewController: BaseViewController {
    
    // MARK: - property
    
    private let logoImage = UIImageView(image: ImageLiterals.imgLogo)
    private let userButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private let toolBarView = HomeViewControllerToolBar()

    // MARK: - life cycle
    
    override func configUI() {
        super.configUI()
    }
    
    override func render() {
        view.addSubview(toolBarView)
        toolBarView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(76)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()

        let logoView = makeBarButtonItem(with: logoImage)
        let rightButton = makeBarButtonItem(with: userButton)

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = logoView
        navigationItem.rightBarButtonItem = rightButton
    }
}
