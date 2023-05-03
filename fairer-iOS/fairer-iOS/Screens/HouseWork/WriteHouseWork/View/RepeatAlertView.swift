//
//  RepeatAlertView.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/04/09.
//

import UIKit

import SnapKit

enum RepeatAlertType {
    case delete
    case edit
    
    var title: String {
        switch self {
        case .delete:
            return TextLiteral.repeatAlertTableViewDeleteTitleLabel
        case .edit:
            return TextLiteral.repeatAlertTableViewEditTitleLabel
        }
    }
    
    var actionButtonTitle: String {
        switch self {
        case .delete:
            return TextLiteral.repeatAlertTableViewDeleteButtonText
        case .edit:
            return TextLiteral.repeatAlertTableViewEditButtonText
        }
    }
    
    var actionButtonColor: UIColor {
        switch self {
        case .delete:
            return .negative20
        case .edit:
            return .blue
        }
    }
}

enum ScheduleActionType: String {
    case once = "O"
    case here = "H"
    case all = "A"
}

final class RepeatAlertView: BaseUIView {
    
    private let tableViewList = TextLiteral.repeatTableViewList
    var alertType: RepeatAlertType = .delete {
        didSet {
            setupAttribute()
        }
    }
    var actionType: ScheduleActionType?
    var didTappedActionType: ((ScheduleActionType) -> ())?
    
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
        label.font = .h3
        label.textColor = .gray800
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepeatAlertTableViewCell.self, forCellReuseIdentifier: RepeatAlertTableViewCell.cellId)
        tableView.rowHeight = 57
        tableView.separatorStyle = .none
        return tableView
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle(TextLiteral.repeatAlertTableViewCancelButtonText, for: .normal)
        button.setBackgroundColor(.normal0, for: .normal)
        button.setTitleColor(.gray800, for: .normal)
        button.titleLabel?.font = .title2
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.normal0, for: .normal)
        button.titleLabel?.font = .title2
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        setCancelButton()
        setActionButton()
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func render() {
        self.addSubview(blurView)
        blurView.addSubview(backgroundView)
        backgroundView.addSubviews(titleLabel, tableView, cancelButton, actionButton)
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.width.equalTo(312)
            $0.height.equalTo(336)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(171)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(backgroundView.snp.bottom).inset(19)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }
        
        actionButton.snp.makeConstraints {
            $0.bottom.equalTo(backgroundView.snp.bottom).inset(19)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }
    }
    
    private func setupAttribute() {
        titleLabel.text = alertType.title
        actionButton.setTitle(alertType.actionButtonTitle, for: .normal)
        actionButton.setTitleColor(alertType.actionButtonColor, for: .normal)
        tableView.selectRow(at: nil, animated: false, scrollPosition: .none)
    }
    
    private func setCancelButton() {
        let action = UIAction { [weak self] _ in
            self?.isHidden = true
        }
        cancelButton.addAction(action, for: .touchUpInside)
    }
    
    private func setActionButton() {
        let action = UIAction { [weak self] _ in
            if let actionType = self?.actionType {
                self?.didTappedActionType?(actionType)
                self?.isHidden = true
            }
        }
        actionButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: - extension

extension RepeatAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            actionType = .once
        case 1:
            actionType = .here
        case 2:
            actionType = .all
        default:
            return
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepeatAlertTableViewCell.cellId, for: indexPath) as! RepeatAlertTableViewCell
        
        cell.label.text = tableViewList[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}
