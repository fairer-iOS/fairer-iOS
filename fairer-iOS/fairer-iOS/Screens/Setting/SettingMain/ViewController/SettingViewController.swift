//
//  SettingViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/11/01.
//

import UIKit

import SnapKit

struct SettingModel {
    let cellImage: UIImage
    let cellLabel: String
    
    static let settingData: [SettingModel] = [SettingModel(cellImage: ImageLiterals.settingProfile, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[0]), SettingModel(cellImage: ImageLiterals.settingPeople, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[1]), SettingModel(cellImage: ImageLiterals.settingBell, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[2]), SettingModel(cellImage: ImageLiterals.settingExclamation, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[3]), SettingModel(cellImage: ImageLiterals.settingInfo, cellLabel: TextLiteral.settingViewControllerTableViewCellLabelList[4])]
    
    static let pushView: [UIViewController] = [
        SettingProfileViewController(),
        ManageHouseViewController(),
        SettingAlarmViewController(),
        SettingInquiryViewController(),
        SettingPolicyViewController()
    ]
}

final class SettingViewController: BaseViewController {
        
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingTableView = UITableView()
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingViewControllerVersionLabel, lineHeight: 22)
        label.textColor = .gray800
        label.font = .body2
        return label
    }()
    private let versionText: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: TextLiteral.settingViewControllerVersionText, lineHeight: 18)
        label.textColor = .gray800
        label.font = .caption1
        return label
    }()
    private let versionDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.settingViewControllerLogoutButtonText, for: .normal)
        button.setTitleColor(.negative20, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.touchUpToLogout()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let logoutDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    private lazy var leaveButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.settingViewControllerLeaveButtonText, for: .normal)
        button.setTitleColor(.negative20, for: .normal)
        button.titleLabel?.font = .body2
        let action = UIAction { [weak self] _ in
            self?.touchUpToLeave()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    private let leaveDivider: UIView = {
       let view = UIView()
        view.backgroundColor = .gray100
        return view
    }()
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupAttribute()
    }
    
    override func render() {
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(280)
        }
        
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(settingTableView.snp.bottom).offset(73)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(versionText)
        versionText.snp.makeConstraints {
            $0.centerY.equalTo(versionLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        view.addSubview(versionDivider)
        versionDivider.snp.makeConstraints {
            $0.top.equalTo(versionLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(versionDivider).offset(17)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        view.addSubview(logoutDivider)
        logoutDivider.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
        }
        
        view.addSubview(leaveButton)
        leaveButton.snp.makeConstraints {
            $0.top.equalTo(logoutDivider).offset(17)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        view.addSubview(leaveDivider)
        leaveDivider.snp.makeConstraints {
            $0.top.equalTo(leaveButton.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(1)
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
        settingTableView.delegate = self
        settingTableView.dataSource = self
    }
    
    private func setupAttribute() {
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        settingTableView.rowHeight = 56
        settingTableView.separatorStyle = .none
        settingTableView.isScrollEnabled = false
    }
    
    private func touchUpToLogout() {
        self.makeRequestAlert(title: TextLiteral.settingViewControllerLogoutAlertTitle, message: "", okTitle: TextLiteral.settingViewControllerAlertOkTitle) { [weak self] _ in
            self?.postLogout()
        }
    }
    
    private func postLogout() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        RootHandler.shared.change(root: .login)
    }
    
    private func touchUpToLeave() {
        self.makeRequestAlert(title: TextLiteral.settingViewControllerLeaveAlertTitle, message: TextLiteral.settingViewControllerLeaveAlertMessage, okTitle: TextLiteral.settingViewControllerLeaveButtonText) { [weak self] _ in
            self?.postLogout()
        }
    }
}

// MARK: - extension

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingModel.settingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        
        cell.cellLabel.text = SettingModel.settingData[indexPath.row].cellLabel
        cell.cellImage.image = SettingModel.settingData[indexPath.row].cellImage
        cell.selectionStyle = .none
        
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(SettingModel.pushView[indexPath.row], animated: true)
    }
}
