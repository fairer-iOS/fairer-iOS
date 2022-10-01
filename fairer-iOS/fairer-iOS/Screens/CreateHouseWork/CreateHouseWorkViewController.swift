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
    private let infoLabelView: InfoLabelView = {
        let view = InfoLabelView()
        view.text = TextLiteral.createWorkInfoLabel
        view.imageColor = .gray200
        view.textColor = .gray600
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
        
        view.addSubview(infoLabelView)
        infoLabelView.snp.makeConstraints {
            $0.top.equalTo(spaceCollectionView.snp.bottom).offset(12)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(createWorkButtonView)
        createWorkButtonView.snp.makeConstraints {
            $0.top.equalTo(infoLabelView.snp.bottom).offset(32)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
        }
        

    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
}
