//
//  RankSectionFooterReusableView.swift
//  fairer-iOS
//
//  Created by 김규철 on 2023/08/30.
//

import UIKit

final class RankSectionFooterReusableView: UICollectionReusableView {
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarchy() {
        self.addSubviews(divider)
    }
    
    private func render() {
        divider.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
}
