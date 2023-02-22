//
//  WorkerIconCollectionViewCell.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/02/20.
//

import UIKit

import SnapKit

final class WorkerCollectionViewCell: BaseCollectionViewCell {

    // MARK: - property
    
    let workerIconImage = UIImageView()
    
    // MARK: - life cycle
    
    override func render() {
        self.addSubview(workerIconImage)
        workerIconImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
