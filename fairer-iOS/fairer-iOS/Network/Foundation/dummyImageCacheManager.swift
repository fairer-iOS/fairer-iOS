//
//  ImageCacheManager.swift
//  fairer-iOS
//
//  Created by 홍준혁 on 2023/03/27.
//

import UIKit

class dummyImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
