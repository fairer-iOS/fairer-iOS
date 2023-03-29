//
//  ImageCacheManager.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/19.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
