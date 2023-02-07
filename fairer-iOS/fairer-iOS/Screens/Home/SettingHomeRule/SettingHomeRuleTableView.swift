//
//  SettingHomeRuleTableView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/02/07.
//

import UIKit

import SnapKit

class SettingHomeRuleTableView: BaseUIView {
    
    private let userList = ["고가혜", "권진혁", "최지혜", "신동빈", "김수연"]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "규칙"
        label.textColor = .black
        label.font = .h2
        return label
    }()
    private lazy var homeRuleTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(cell: SettingHomeRuleTableViewCell.self,
                           forCellReuseIdentifier: SettingHomeRuleTableViewCell.cellId)
        return tableView
    }()
    
    override func render() {
        addSubviews(titleLabel, homeRuleTableView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.trailing.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        homeRuleTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
        }
        
//        if #available(iOS 15, *) {
//            homeRuleTableView.sectionHeaderTopPadding = 0
//        }
    }
}

extension SettingHomeRuleTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeRuleTableView.dequeueReusableCell(withIdentifier: SettingHomeRuleTableViewCell.cellId, for: indexPath) as! SettingHomeRuleTableViewCell

        cell.ruleLabel.text = userList[indexPath.item]

        return cell
    }
}

