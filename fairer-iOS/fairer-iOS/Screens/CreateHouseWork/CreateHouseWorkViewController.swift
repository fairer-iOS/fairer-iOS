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
    private let createWorkButtonView: CreateWorkButtonView = {
        let view = CreateWorkButtonView()
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.positive20.cgColor
        return view
    }()
    
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
        
        view.addSubview(createWorkButtonView)
        createWorkButtonView.snp.makeConstraints {
            $0.top.equalTo(spaceCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
}
