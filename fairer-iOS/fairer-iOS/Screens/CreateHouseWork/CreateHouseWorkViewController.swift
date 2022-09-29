//
//  CreateHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class CreateHouseWorkViewController: BaseViewController {
    
    // MARK: - property
    
    private let spaceCollectionView = SelectHouseWorkSpaceCollectionView()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
        configUI()
    }
    
    override func render() {
        view.addSubview(spaceCollectionView)
        spaceCollectionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(224)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
}
