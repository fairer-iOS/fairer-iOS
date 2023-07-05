//
//  SettingAlarmViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/12/19.
//

import UIKit

import SnapKit

final class SettingAlarmViewController: BaseViewController {
    
    private var alarmRequest = AlarmRequest(notCompleteStatus: false, scheduledTimeStatus: false)
    
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
    
    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonAction()
        getAlarmStatus()
    }
    
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
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setButtonAction() {
        let alarmAction = UIAction {[weak self] _ in
            self?.didTappedToggle()
        }
        timeAlarmCell.cellToggle.addAction(alarmAction, for: .touchUpInside)
        remindAlarmCell.cellToggle.addAction(alarmAction, for: .touchUpInside)
    }
    
    private func setAlarmStatus(alarmStatus: AlarmResponse) {
        guard let scheduledTimeStatus = alarmStatus.scheduledTimeStatus, let notCompleteStatus = alarmStatus.notCompleteStatus else { return }
        timeAlarmCell.cellToggle.isOn = scheduledTimeStatus
        remindAlarmCell.cellToggle.isOn = notCompleteStatus
    }
    
    private func didTappedToggle() {
        alarmRequest.scheduledTimeStatus = timeAlarmCell.cellToggle.isOn
        alarmRequest.notCompleteStatus = remindAlarmCell.cellToggle.isOn
        putAlarmStatus(body: alarmRequest)
    }
}

// MARK: - api

extension SettingAlarmViewController {
    func getAlarmStatus() {
        NetworkService.shared.alarm.getAlarmStatus { result in
            switch result {
            case .success(let response):
                if let alarmStatus = response as? AlarmResponse {
                    self.setAlarmStatus(alarmStatus: alarmStatus)
                }
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
    
    func putAlarmStatus(body: AlarmRequest) {
        NetworkService.shared.alarm.putAlarmStatus(body: body) { result in
            switch result {
            case .success(let response):
                break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                break
            }
        }
    }
}
