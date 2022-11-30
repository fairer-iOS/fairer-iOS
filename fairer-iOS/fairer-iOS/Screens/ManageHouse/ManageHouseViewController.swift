//
//  ManageHouseViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/19.
//

import UIKit

import SnapKit

struct ManageHouseModel {
    let cellImage: UIImage
    let cellLabel: String
    
    static let manageHouseData: [ManageHouseModel] = [ManageHouseModel(cellImage: ImageLiterals.settingProfile, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[0]), ManageHouseModel(cellImage: ImageLiterals.settingPeople, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[1])]
}

final class ManageHouseViewController: BaseViewController {

    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let manageHouseTableView = UITableView()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupAttribute()
    }
    
    override func render() {
        view.addSubview(manageHouseTableView)
        manageHouseTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(112)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = TextLiteral.settingViewControllerNavigationBarTitleLabel
    }
    
    private func setupDelegate() {
        manageHouseTableView.delegate = self
        manageHouseTableView.dataSource = self
    }
    
    private func setupAttribute() {
        manageHouseTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        manageHouseTableView.rowHeight = 56
        manageHouseTableView.separatorStyle = .none
    }
}
