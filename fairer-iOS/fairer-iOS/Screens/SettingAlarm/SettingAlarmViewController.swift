//
//  SettingAlarmViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

import SnapKit

final class SettingAlarmViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let timeAlarmCell: SettingAlarmViewCell = {
        let cell = SettingAlarmViewCell()
        cell.labelText = TextLiteral.settingAlarmViewControllerTimeAlarmCellText
        return cell
    }()
    private let remindAlarmCell: SettingAlarmViewCell = {
        let cell = SettingAlarmViewCell()
        cell.labelText = TextLiteral.settingAlarmViewControllerRemindAlarmCellText
        return cell
    }()
    private let morningAlarmCell: SettingAlarmViewCell = {
        let cell = SettingAlarmViewCell()
        cell.labelText = TextLiteral.settingAlarmViewControllerMorningAlarmCellText
        return cell
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(timeAlarmCell)
        timeAlarmCell.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
        
        view.addSubview(remindAlarmCell)
        remindAlarmCell.snp.makeConstraints {
            $0.top.equalTo(timeAlarmCell.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
        
        view.addSubview(morningAlarmCell)
        morningAlarmCell.snp.makeConstraints {
            $0.top.equalTo(remindAlarmCell.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(56)
        }
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
}
