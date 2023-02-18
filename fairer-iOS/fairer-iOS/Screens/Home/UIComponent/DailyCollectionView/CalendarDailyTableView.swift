//
//  CalendarDailyTableView.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/01/13.
//

import UIKit

import SnapKit

struct dummyWorkCard {
    let work = ["바닥 청소","설거지","빨래","바닥 청소","설거지","빨래","설거지"]
    let time = ["오전 9:30","오후 8:00","오전 11:00","오전 9:30","오후 8:00","오전 11:00","오전 11:00"]
    let room = ["방","부엌","거실","방","부엌","방","부엌"]
    let status = [ WorkState.overdue,WorkState.overdue,WorkState.notFinished,WorkState.finished,WorkState.finished,WorkState.finished,WorkState.finished]
}

final class CalendarDailyTableView: BaseUIView  {
    
    private var cellNum = 0
    var changeHeightClosure: ((Int)->())?

    // MARK: - TODO.API
    
    private let dummy = dummyWorkCard()
    
    // MARK: - property

    var calendarDailyTableView = UITableView()
    
    // MARK: - life cycle
    
    override func render() {
        
        setupDelegation()
        
        self.addSubview(calendarDailyTableView)
        
        calendarDailyTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupDelegation() {
        calendarDailyTableView.register(CalendarDailyTableViewCell.self, forCellReuseIdentifier: CalendarDailyTableViewCell.identifier)
        calendarDailyTableView.delegate = self
        calendarDailyTableView.dataSource = self
    }
    
}

// MARK: - Extension

extension CalendarDailyTableView: UITableViewDelegate {}
extension CalendarDailyTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }else {
            return "끝낸 집안일"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                cellNum = cellNum + 3
                return 3
            }else {
            cellNum = cellNum + 4
            changeHeightClosure?(cellNum)
            cellNum = 0
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = calendarDailyTableView.dequeueReusableCell(withIdentifier: CalendarDailyTableViewCell.identifier, for: indexPath) as? CalendarDailyTableViewCell ?? CalendarDailyTableViewCell()
        cell.selectionStyle = .none
        cell.workLabel.text = dummy.work[indexPath.item]
        cell.time.text = dummy.time[indexPath.item]
        cell.room.text = dummy.room[indexPath.item]
        switch dummy.status[indexPath.item] {
        case .finished :
            cell.backgroundColor = .positive10
        case .notFinished :
            cell.backgroundColor = .white
        case .overdue :
            cell.backgroundColor = .negative0
            cell.layer.borderColor = UIColor.negative10.cgColor
            cell.setErrorImageView()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
}
