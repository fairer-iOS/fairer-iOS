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
    
    static let manageHouseData: [ManageHouseModel] = [ManageHouseModel(cellImage: ImageLiterals.settingProfile, cellLabel: TextLiteral.manageHouseViewControllerTableViewCellLabelList[0]), ManageHouseModel(cellImage: ImageLiterals.settingPeople, cellLabel: TextLiteral.manageHouseViewControllerTableViewCellLabelList[1])]
}

final class ManageHouseViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let manageHouseTableView = UITableView()
    private lazy var leaveHouseButton: UIButton = {
        let button = UIButton()
        button.setTitle("하우스에서 나가기", for: .normal)
        button.setTitleColor(.negative20, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let leaveHouseDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private let differentHouseImage: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.imgInfo
        image.tintColor = .gray200
        return image
    }()
    private lazy var differentHouseButton: UIButton = {
        let button = UIButton()
        button.setTitle("다른 공간에 참여하고 싶다면?", for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            print("됨")
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let bubbleBackgroundView = UIImageView(image: ImageLiterals.imgBubble)
    
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
        
        view.addSubview(leaveHouseButton)
        leaveHouseButton.snp.makeConstraints {
            $0.top.equalTo(manageHouseTableView.snp.bottom).offset(17)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        view.addSubview(leaveHouseDivider)
        leaveHouseDivider.snp.makeConstraints {
            $0.top.equalTo(leaveHouseButton.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(differentHouseImage)
        differentHouseImage.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.width.height.equalTo(16)
        }
        
        view.addSubview(differentHouseButton)
        differentHouseButton.snp.makeConstraints {
            $0.centerY.equalTo(differentHouseImage.snp.centerY)
            $0.leading.equalTo(differentHouseImage.snp.trailing).offset(8)
        }
        
        view.addSubview(bubbleBackgroundView)
        bubbleBackgroundView.snp.makeConstraints {
            $0.bottom.equalTo(differentHouseButton.snp.top).offset(5)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
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

// MARK: - extension

extension ManageHouseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManageHouseModel.manageHouseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = manageHouseTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        
        cell.cellLabel.text = ManageHouseModel.manageHouseData[indexPath.row].cellLabel
        cell.cellImage.image = ManageHouseModel.manageHouseData[indexPath.row].cellImage
        
        return cell
    }
}
