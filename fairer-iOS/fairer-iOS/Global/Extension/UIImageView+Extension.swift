//
//  UIImageView+Extension.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/11.
//

import Foundation
import UIKit

extension UIImageView {
    func load(from url: String) {
        
        let cacheKey = NSString(string: url)
        if let cachedImage = dummyImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            if let imageUrl = URL(string: url),
               let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
