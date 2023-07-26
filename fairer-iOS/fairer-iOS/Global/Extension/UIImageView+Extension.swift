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
        let firstImageURL = url.components(separatedBy: "Fic_")[1]
        let finalImageURL = firstImageURL.components(separatedBy: ".svg")[0]
        switch finalImageURL {
        case "profile1": self.image = ImageLiterals.profileBlue3
        case "profile2": self.image = ImageLiterals.profileBlue4
        case "profile3": self.image = ImageLiterals.profilePink1
        case "profile4": self.image = ImageLiterals.profileOrange1
        case "profile5": self.image = ImageLiterals.profilePink3
        case "profile6": self.image = ImageLiterals.profilePurple1
        case "profile7": self.image = ImageLiterals.profilePurple2
        case "profile8": self.image = ImageLiterals.profilePurple3
        case "profile9": self.image = ImageLiterals.profileOrange2
        case "profile10": self.image = ImageLiterals.profileYellow2
        case "profile11": self.image = ImageLiterals.profileIndigo3
        case "profile12": self.image = ImageLiterals.profileGreen1
        case "profile13": self.image = ImageLiterals.profileYellow1
        case "profile14": self.image = ImageLiterals.profileGreen3
        case "profile15": self.image = ImageLiterals.profileLightBlue1
        case "profile16": self.image = ImageLiterals.profileLightBlue2
        default: return
        }
    }
}
