//
//  CreateHouseWorkViewController.swift
//  fairer-iOS
//
//  Created by LeeSungHo on 2022/09/20.
//

import UIKit

import SnapKit

final class CreateHouseWorkViewController: BaseViewController {
    
    // MARK: - property
    
    private let backButton = BackButton(type: .system)
    private let createHouseWorkCalendar = CreateHouseWorkCalendarView()
    private let spaceCollectionView = SelectHouseWorkSpaceCollectionView()
    private let spaceInfoLabel: InfoLabelView = {
        let label = InfoLabelView()
        label.text = "공간을 선택하면 세부 집안일이 나옵니다."
        label.textColor = .gray600
        label.imageColor = .gray200
        return label
    }()
    private lazy var writeHouseWorkButton: WriteHouseWorkButton = {
        let button = WriteHouseWorkButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.positive20.cgColor
        button.layer.cornerRadius = 6
        let action = UIAction { [weak self] _ in
            self?.didTappedWriteHouseWorkButton()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    
    override func render() {
        view.addSubview(createHouseWorkCalendar)
        createHouseWorkCalendar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(4)
            $0.leading.equalToSuperview().inset(15)
        }
        
        view.addSubview(spaceCollectionView)
        spaceCollectionView.snp.makeConstraints {
            $0.top.equalTo(createHouseWorkCalendar.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(248)
        }
        
        view.addSubview(spaceInfoLabel)
        spaceInfoLabel.snp.makeConstraints {
            $0.top.equalTo(spaceCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(22)
        }
        
        view.addSubview(writeHouseWorkButton)
        writeHouseWorkButton.snp.makeConstraints {
            $0.top.equalTo(spaceInfoLabel.snp.bottom).offset(32)
            $0.horizontalEdges.equalToSuperview().inset(SizeLiteral.leadingTrailingPadding)
            $0.height.equalTo(42)
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
    
    private func didTappedWriteHouseWorkButton() {
        // FIXME: - 집안일 직접 입력하기 페이지로 이동
        print("집안일 직접 입력하기")
    }
}
