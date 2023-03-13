//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

import SnapKit

import Moya

class SettingHomeRuleViewController: BaseViewController {
    
    var dummyList = ["고가혜", "권진혁", "최지혜", "신동빈", "김수연", "김수연", "김수연", "김수연"]
    
    var ruleData: [ruleData] = []
    
    private let maxLength = 16
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingHomeRulePrimaryLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRulePrimaryLabel
        label.textColor = .gray800
        label.font = .h2
        return label
    }()
    private let settingHomeRuleTextFieldLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRuleTextFieldLabel
        label.textColor = .gray600
        label.font = .title1
        return label
    }()
    private let settingHomeRuleTextField = TextField(type: .medium, placeHolder: TextLiteral.settingHomeRuleTextFieldPlaceholder)

    private let settingHomeRuleTextFieldeWarningLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "텍스트는 16글자를 초과하여 입력하실 수 없어요.", lineHeight: 22)
        label.textColor = .negative20
        label.font = .body2
        label.isHidden = true
        return label
    }()
    private lazy var settingHomeRuleTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingHomeRuleTextField,settingHomeRuleTextFieldeWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    private let settingHomeRuleInfoLabel: InfoLabelView = {
        let label = InfoLabelView()
        label.text = TextLiteral.settingHomeRuleInfoLabel
        label.textColor = .gray600
        label.imageColor = .gray200
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.homeRuleViewRuleLabel
        label.textColor = .gray600
        label.font = .h2
        return label
    }()
    private let homeRuleTableView = UITableView()
    
    // MARK: - life cycle
        
    override func render() {
        view.addSubviews(settingHomeRulePrimaryLabel, settingHomeRuleTextFieldLabel, settingHomeRuleTextFieldStackView, settingHomeRuleInfoLabel, titleLabel, homeRuleTableView)
        
        settingHomeRulePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleTextFieldLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRulePrimaryLabel.snp.bottom).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleTextFieldStackView.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextFieldLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleInfoLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextFieldStackView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleInfoLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        homeRuleTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
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
        settingHomeRuleTextField.delegate = self
        homeRuleTableView.delegate = self
        homeRuleTableView.dataSource = self
    }
    
    private func setupAttribute() {
        homeRuleTableView.register(SettingHomeRuleTableViewCell.self, forCellReuseIdentifier: SettingHomeRuleTableViewCell.cellId)
        homeRuleTableView.rowHeight = 74
        homeRuleTableView.separatorStyle = .none
        homeRuleTableView.showsVerticalScrollIndicator = false
        homeRuleTableView.backgroundColor = .white
    }
    
    @objc func deleteBtnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: homeRuleTableView)
        guard let indexPath = homeRuleTableView.indexPathForRow(at: point) else { return }
        dummyList.remove(at: indexPath.row)
        homeRuleTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    
    private func checkMaxLength() {
            if let text = settingHomeRuleTextField.text {
                if text.count > maxLength {
                    settingHomeRuleTextField.layer.borderColor = UIColor.negative20.cgColor
                    settingHomeRuleTextField.layer.borderWidth = 1
                    settingHomeRuleTextFieldeWarningLabel.isHidden = false
                } else {
                    settingHomeRuleTextField.layer.borderColor = UIColor.gray200.cgColor
                    settingHomeRuleTextField.layer.borderWidth = 1
                    settingHomeRuleTextFieldeWarningLabel.isHidden = true
                }
            }
        }
    }

    // MARK: - extension

extension SettingHomeRuleViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkMaxLength()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           if !isEditing {
               isEditing = true
               checkMaxLength()
           }
       }

    func textFieldDidEndEditing(_ textField: UITextField) {
           if isEditing {
               isEditing = false
               settingHomeRuleTextField.layer.borderWidth = 0
           }
       }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let text = settingHomeRuleTextField.text {
            if !text.isEmpty && text.count <= maxLength {
                postRules(ruleName: text) { data in
                    guard let ruleData = data.ruleResponseDtos?.last else { return }
                    self.ruleData.append(ruleData)
                    
                    DispatchQueue.main.async {
                        self.homeRuleTableView.reloadData()
                    }
                }
                settingHomeRuleTextField.text =  ""
                settingHomeRuleTextField.resignFirstResponder()
            }
        }
        return true
    }
}

extension SettingHomeRuleViewController: UITableViewDelegate, UITableViewDataSource {
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

extension SettingHomeRuleViewController {
    func getRules() {
        NetworkService.shared.rules.getRules { result in
            switch result {
            case .success(let response):
                guard let rules = response as? RulesResponse else { return }
                guard let ruleData = rules.ruleResponseDtos else { return }
                self.ruleData = ruleData
                self.homeRuleTableView.reloadData()

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
                guard let error = errorResponse as? ServerErrorResponse else { return }
                
                self.settingHomeRuleTextFieldeWarningLabel.text = error.errorMessage
                self.settingHomeRuleTextFieldeWarningLabel.isHidden = false
                self.settingHomeRuleTextField.layer.borderColor = UIColor.negative20.cgColor
                self.settingHomeRuleTextField.layer.borderWidth = 1
                
            default:
                print("server error")
            }
        }
    }
}
