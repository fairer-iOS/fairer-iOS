//
//  UIImageView+Extension.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/11.
//

import UIKit

extension UIImageView {
    func load(from url: URL) {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
