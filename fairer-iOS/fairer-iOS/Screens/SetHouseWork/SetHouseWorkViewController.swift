//
//  SetHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/01/19.
//

import UIKit

import SnapKit

final class SetHouseWorkViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let setHouseWorkCalendarView = SetHouseWorkCalendarView()
    private let setHouseWorkCollectionView = SetHouseWorkCollectionView()
    private lazy var getManagerView: GetManagerView = {
        let view = GetManagerView()
        let action = UIAction { [weak self] _ in
            self?.showSelectManagerView()
        }
        view.addManagerButton.addAction(action, for: .touchUpInside)
        return view
    }()
    private lazy var selectManagerView: SelectManagerView = {
        let view = SelectManagerView()
        let cancelAction = UIAction { [weak self] _ in
            self?.didTappedCancelButton()
        }
        let confirmAction = UIAction { [weak self] _ in
            self?.didTappedConfirmButton()
        }
        view.cancelButton.addAction(cancelAction, for: .touchUpInside)
        view.confirmButton.addAction(confirmAction, for: .touchUpInside)
        return view
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(setHouseWorkCalendarView)
        setHouseWorkCalendarView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(38)
        }
        
        view.addSubview(setHouseWorkCollectionView)
        setHouseWorkCollectionView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCalendarView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(134)
        }
        
        view.addSubview(getManagerView)
        getManagerView.snp.makeConstraints {
            $0.top.equalTo(setHouseWorkCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        view.addSubview(selectManagerView)
        selectManagerView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0)
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
    
    private func showSelectManagerView() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(341)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlUp, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func didTappedCancelButton() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlDown, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func didTappedConfirmButton() {
        selectManagerView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCurlDown, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        getManagerView.getManagerCollectionView.selectedMemberList = selectManagerView.selectManagerCollectionView.selectedManagerList
    }
}
