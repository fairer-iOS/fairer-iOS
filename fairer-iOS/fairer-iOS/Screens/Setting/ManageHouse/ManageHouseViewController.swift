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
        button.setTitle(TextLiteral.manageHouseViewControllerLeaveHouseButtonText, for: .normal)
        button.setTitleColor(.negative20, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.touchUpToLeaveHouse()
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
        button.setTitle(TextLiteral.manageHouseViewControllerDifferentHouseButtonText, for: .normal)
        button.setTitleColor(.gray600, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.touchUpToShowBubble()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let bubbleBackgroundView: UIImageView = {
        let image = UIImageView()
        image.image = ImageLiterals.imgBubble
        image.alpha = 0
        return image
    }()
    private let bubbleText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.manageHouseViewControllerBubbleText, lineHeight: 20)
        label.textColor = .gray700
        label.font = .title2
        label.numberOfLines = 2
        label.alpha = 0
        return label
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupAttribute()
    }
    
    override func render() {
        view.addSubview(manageHouseTableView)
        manageHouseTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(4)
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
        
        bubbleBackgroundView.addSubview(bubbleText)
        bubbleText.snp.makeConstraints {
            $0.top.equalTo(bubbleBackgroundView.snp.top).inset(6)
            $0.leading.equalTo(bubbleBackgroundView.snp.leading).inset(16)
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
        manageHouseTableView.isScrollEnabled = false
        
    }
    
    private func touchUpToShowBubble() {
        UIView.animate(withDuration: 0.8, delay: 0.1, animations: {
            if self.bubbleBackgroundView.alpha == 0 {
                self.bubbleBackgroundView.alpha = 1.0
                self.bubbleText.alpha = 1.0
            } else {
                self.bubbleBackgroundView.alpha = 0
                self.bubbleText.alpha = 0
            }
        })
    }
    
    private func touchUpToLeaveHouse() {
        // FIXME: - 하우스 나가기 api 연결
        self.makeRequestAlert(title: TextLiteral.manageHouseViewControllerAlertTitle, message: TextLiteral.manageHouseViewControllerAlertMessage, okTitle: TextLiteral.manageHouseViewControllerAlertOkTitle, cancelTitle: TextLiteral.manageHouseViewControllerAlertCancelTitle, okAction: { _ in print("하우스에서 나가기") }, cancelAction: nil, completion: nil)
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
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(ChangeHouseNameViewController(), animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
