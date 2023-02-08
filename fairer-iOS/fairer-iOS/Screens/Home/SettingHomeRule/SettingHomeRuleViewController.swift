//
//  SettingHomeRuleViewController.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/06.
//

import UIKit

import SnapKit

class SettingHomeRuleViewController: BaseViewController {
    
    var dummyList = ["고가혜", "권진혁", "최지혜", "신동빈", "김수연", "김수연", "김수연", "김수연"]
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let settingHomeRulePrimaryLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRulePrimaryLabel
        label.textColor = .black
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
    private let settingHomeRuleTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray200.cgColor
        textField.myPlaceholder = TextLiteral.settingHomeRuleTextFieldPlaceholder
        textField.setClearButton()
        return textField
    }()
    private let HomeRuleTextFieldeWarningLabel: UILabel = {
        let label = UILabel()
        label.setTextWithLineHeight(text: "텍스트는 16글자를 초과하여 입력하실 수 없어요.", lineHeight: 22)
        label.textColor = .negative20
        label.font = .body2
        label.isHidden = true
        return label
    }()
    private lazy var HomeRuleTextFieldStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingHomeRuleTextField,HomeRuleTextFieldeWarningLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    private let settingHomeRuleInfoPin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.settingInfo
        return imageView
    }()
    private let settingHomeRuleInfoLabel: UILabel = {
        let label = UILabel()
        label.text = TextLiteral.settingHomeRuleInfoLabel
        label.textColor = .gray600
        label.font = .body2
        return label
    }()
    private lazy var settingHomeRuleInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [settingHomeRuleInfoPin,settingHomeRuleInfoLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "규칙"
        label.textColor = .black
        label.font = .h2
        return label
    }()
    private lazy var homeRuleTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(cell: SettingHomeRuleTableViewCell.self,
                           forCellReuseIdentifier: SettingHomeRuleTableViewCell.cellId)
        return tableView
    }()
    
    // MARK: - life cycle
        
    override func configUI() {
        view.backgroundColor = .white
    }
    override func render() {
        view.addSubviews(settingHomeRulePrimaryLabel, settingHomeRuleTextFieldLabel, HomeRuleTextFieldStackView, settingHomeRuleInfoStackView, titleLabel, homeRuleTableView)
        
        settingHomeRulePrimaryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleTextFieldLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRulePrimaryLabel.snp.bottom).offset(SizeLiteral.topPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        HomeRuleTextFieldStackView.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleTextFieldLabel.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        settingHomeRuleInfoStackView.snp.makeConstraints {
            $0.top.equalTo(HomeRuleTextFieldStackView.snp.bottom).offset(SizeLiteral.componentPadding)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(settingHomeRuleInfoStackView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        homeRuleTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
    }
     
    // MARK: - func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let backButton = makeBarButtonItem(with: backButton)
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupDelegation() {
        settingHomeRuleTextField.delegate = self
    }
    
    @objc func deleteBtnAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: homeRuleTableView)
        guard let indexPath = homeRuleTableView.indexPathForRow(at: point) else { return }
        dummyList.remove(at: indexPath.row)
        homeRuleTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    
     func checkMaxLength() {
            let maxLength = 16
            if let text = settingHomeRuleTextField.text {
                if text.count > maxLength {
                    settingHomeRuleTextField.layer.borderWidth = 1
                    settingHomeRuleTextField.layer.borderColor = UIColor.negative20.cgColor
                    HomeRuleTextFieldeWarningLabel.isHidden = false
                } else {
                    settingHomeRuleTextField.layer.borderWidth = 0
                    HomeRuleTextFieldeWarningLabel.isHidden = true
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if let text = settingHomeRuleTextField.text {
            dummyList.append(text)
            
            DispatchQueue.main.async {
                self.homeRuleTableView.reloadData()
            }
            
            settingHomeRuleTextField.text =  ""
            settingHomeRuleTextField.resignFirstResponder()
        }
        return true
    }
}

extension SettingHomeRuleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeRuleTableView.dequeueReusableCell(withIdentifier: SettingHomeRuleTableViewCell.cellId, for: indexPath) as! SettingHomeRuleTableViewCell
        
        cell.selectionStyle = .none
        
        cell.clearButton.addTarget(self, action: #selector(deleteBtnAction(_:)), for: .touchUpInside)
        
        cell.ruleLabel.text = dummyList[indexPath.item]

        return cell
    }
}
