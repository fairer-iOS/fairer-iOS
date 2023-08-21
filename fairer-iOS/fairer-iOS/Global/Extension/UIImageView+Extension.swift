//
//  UIImageView+Extension.swift
//  fairer-iOS
//
//  Created by 김유나 on 2023/03/11.
//

import Foundation
import UIKit

extension UIImageView {
    func loadURL(from url: String) {
        
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            if let imageUrl = URL(string: url),
               let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self.image = image
                    }
                }
            }
        }
    }
    
    func load(from url: String) {
        var finalImageURL = ""
        if url.contains("2F") {
            let firstImageURL = url.components(separatedBy: "2F")[1]
            if firstImageURL.contains("-3x") {
                finalImageURL = firstImageURL.components(separatedBy: "-3x")[0]
            } else if firstImageURL.contains(".svg") {
                finalImageURL = firstImageURL.components(separatedBy: ".svg")[0]
            }
        }
        switch finalImageURL {
        case "ic_profile1", "blue3": self.image = ImageLiterals.profileBlue3
        case "ic_profile2", "blue4": self.image = ImageLiterals.profileBlue4
        case "ic_profile3", "pink1": self.image = ImageLiterals.profilePink1
        case "ic_profile4", "orange1": self.image = ImageLiterals.profileOrange1
        case "ic_profile5", "pink3": self.image = ImageLiterals.profilePink3
        case "ic_profile6", "purple1": self.image = ImageLiterals.profilePurple1
        case "ic_profile7", "purple2": self.image = ImageLiterals.profilePurple2
        case "ic_profile8", "purple3": self.image = ImageLiterals.profilePurple3
        case "ic_profile9", "orange2": self.image = ImageLiterals.profileOrange2
        case "ic_profile10", "yellow2": self.image = ImageLiterals.profileYellow2
        case "ic_profile11", "indigo3": self.image = ImageLiterals.profileIndigo3
        case "ic_profile12", "green1": self.image = ImageLiterals.profileGreen1
        case "ic_profile13", "yellow1": self.image = ImageLiterals.profileYellow1
        case "ic_profile14", "green3": self.image = ImageLiterals.profileGreen3
        case "ic_profile15", "blue1": self.image = ImageLiterals.profileLightBlue1
        case "ic_profile16", "blue2": self.image = ImageLiterals.profileLightBlue2
        default: self.image = ImageLiterals.profileBlue3
        }
    }
}
