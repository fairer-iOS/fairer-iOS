//
//  RepeatAlertView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/09.
//

import UIKit

import SnapKit

final class RepeatAlertView: BaseUIView {
    
    private let tableViewList = ["이 일정", "이 일정 및 향후 일정", "모든 일정"]
    
    // MARK: - property
    
    private let blurView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "반복 일정 삭제"
        label.font = .h3
        label.textColor = .gray800
        return label
    }()
    private let tableView = UITableView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(blurView)
        blurView.addSubview(backgroundView)
        backgroundView.addSubviews(titleLabel)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(312)
            $0.height.equalTo(336)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - func
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupAttribute() {
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.cellId)
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
    }
}

// MARK: - extension

extension RepeatAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.cellId, for: indexPath) as! SettingTableViewCell
        
        cell.cellLabel.text = tableViewList[indexPath.row]
        
        return cell
    }
}
