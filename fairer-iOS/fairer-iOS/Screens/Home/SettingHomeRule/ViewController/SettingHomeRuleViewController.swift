//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

import SnapKit

import Moya

final class SettingHomeRuleViewController: BaseViewController {
    
    private var ruleData: [RuleData] = []
    private let maxLength = 16
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let homeRuleHeaderView = SettingHomeRuleHeaderView()
    private let homeRuleTableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: - life cycle
        
    override func render() {
        
        view.addSubview(homeRuleTableView)
        
        homeRuleTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        setupAttribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getRules()
    }
    
    // MARK: - func
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        homeRuleTableView.delegate = self
        homeRuleTableView.dataSource = self
    }
    
    private func setupAttribute() {
        homeRuleTableView.register(SettingHomeRuleTableViewCell.self, forCellReuseIdentifier: SettingHomeRuleTableViewCell.cellId)
        homeRuleTableView.register(SettingHomeRuleHeaderView.self, forHeaderFooterViewReuseIdentifier: SettingHomeRuleHeaderView.identifier)
        homeRuleTableView.rowHeight = 64
        homeRuleTableView.separatorStyle = .none
        homeRuleTableView.showsVerticalScrollIndicator = false
        homeRuleTableView.backgroundColor = .white
    }
    
    @objc func deleteBtnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: homeRuleTableView)
        guard let indexPath = homeRuleTableView.indexPathForRow(at: point) else { return }
        let ruleId = self.ruleData[indexPath.row].ruleId
        
        self.ruleData.remove(at: indexPath.row)
        homeRuleTableView.deleteRows(at: [indexPath], with: .automatic)
        
        if ruleData.isEmpty {
            homeRuleTableView.reloadData()
        }
        
        deleteRules(ruleId: ruleId)
    
      }
    
    private func checkMaxLength(textfield: UITextField) {
            
        if let text = textfield.text {
                    if text.count > maxLength {
                    homeRuleHeaderView.settingHomeRuleTextField.layer.borderColor = UIColor.negative20.cgColor
                    homeRuleHeaderView.settingHomeRuleTextField.layer.borderWidth = 1
                    NotificationCenter.default.post(name: Notification.Name("showWarningLabel"), object: nil)
                } else {
                    homeRuleHeaderView.settingHomeRuleTextField.layer.borderColor = UIColor.gray200.cgColor
                    homeRuleHeaderView.settingHomeRuleTextField.layer.borderWidth = 1
                    NotificationCenter.default.post(name: Notification.Name("hideWarningLabel"), object: nil)
                }
            }
        }
    }



extension SettingHomeRuleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = SettingHomeRuleHeaderView(reuseIdentifier: SettingHomeRuleHeaderView.identifier)
        
        headerView.settingHomeRuleTextField.delegate = self
        headerView.settingHomeRuleTextField.tintColor = .blue
        headerView.tintColor = .white
        
        return headerView
    }
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if self.ruleData.isEmpty {
            if let headerView = view as? SettingHomeRuleHeaderView {
                headerView.hiddenTitleLabel()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 340
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ruleData.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeRuleTableView.dequeueReusableCell(withIdentifier: SettingHomeRuleTableViewCell.cellId, for: indexPath) as! SettingHomeRuleTableViewCell
        
        cell.selectionStyle = .none
        cell.clearButton.addTarget(self, action: #selector(deleteBtnAction(_:)), for: .touchUpInside)
        cell.ruleLabel.text = ruleData[indexPath.row].ruleName

        return cell
    }
}

// MARK: - extension

extension SettingHomeRuleViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        homeRuleHeaderView.settingHomeRuleTextField = textField as! TextField
        
        checkMaxLength(textfield: textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        homeRuleHeaderView.settingHomeRuleTextField = textField as! TextField
        
        if !isEditing {
            isEditing = true
            checkMaxLength(textfield: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if isEditing {
            isEditing = false
            homeRuleHeaderView.settingHomeRuleTextField.layer.borderWidth = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = homeRuleHeaderView.settingHomeRuleTextField.text {
            if !text.isEmpty && text.count <= maxLength {
                postRules(ruleName: text) { data in
                    guard let ruleData = data.ruleResponseDtos?.last else { return }
                    self.ruleData.append(ruleData)
                    
                    DispatchQueue.main.async {
                        self.homeRuleTableView.reloadData()
                    }
                    
                    self.homeRuleHeaderView.settingHomeRuleTextField.text =  ""
                    self.homeRuleHeaderView.settingHomeRuleTextField.resignFirstResponder()
                }
            }
        }
        return true
    }
        
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.ruleData.count >= 10 {
            return false
        } else {
            return true
        }
    }
}

extension SettingHomeRuleViewController {
    func getRules() {
        NetworkService.shared.rules.getRules { [weak self] result in
            switch result {
            case .success(let response):
                guard let rules = response as? RulesResponse else { return }
                guard let ruleData = rules.ruleResponseDtos else { return }
                self?.ruleData = ruleData

                self?.homeRuleTableView.reloadData()
                
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("server error")
                
            }
        }
    }
        
    func postRules(ruleName: String, completion: @escaping (RulesResponse) -> Void) {
        NetworkService.shared.rules.postRules(ruleName: ruleName) { result in
            switch result {
            case .success(let response):
                guard let ruleName = response as? RulesResponse else { return }
                completion(ruleName)
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("server error")
            }
        }
    }
    
    func deleteRules(ruleId: Int) {
        NetworkService.shared.rules.deleteRules(ruleId: ruleId) { result in
            switch result {
            case .success: break
            case .requestErr(let errorResponse):
                dump(errorResponse)
            default:
                print("server error")
            }
        }
    }
}
