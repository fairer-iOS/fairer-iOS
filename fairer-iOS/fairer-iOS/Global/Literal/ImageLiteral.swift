//
//  ImageLiteral.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - image

    static var imgLogo: UIImage { .load(name: "fairerlogo")}
    static var imgLogoLogin: UIImage { .load(name: "fairerlogologin")}
    static var imgLogoSplash: UIImage { .load(name: "fairerlogosplash")}
    
    // MARK: - profile
    
    static var profileNone: UIImage { .load(name: "profilenone")}
    static var profileBlue3: UIImage { .load(name: "profileblue3")}
    static var profileBlue4: UIImage { .load(name: "profileblue4")}
    static var profileOrange1: UIImage { .load(name: "profileorange1")}
    static var profilePink1: UIImage { .load(name: "profilepink1")}
    static var profilePink3: UIImage { .load(name: "profilepink3")}
    static var profileOrange2: UIImage { .load(name: "profileorange2")}
    static var profileYellow2: UIImage { .load(name: "profileyellow2")}
    static var profileIndigo3: UIImage { .load(name: "profileindigo3")}
    static var profilePurple1: UIImage { .load(name: "profilepurple1")}
    static var profilePurple2: UIImage { .load(name: "profilepurple2")}
    static var profilePurple3: UIImage { .load(name: "profilepurple3")}
    static var profileGreen1: UIImage { .load(name: "profilegreen1")}
    static var profileYellow1: UIImage { .load(name: "profileyellow1")}
    static var profileGreen3: UIImage { .load(name: "profilegreen3")}
    static var profileLightBlue1: UIImage { .load(name: "profilelightblue1")}
    static var profileLightBlue2: UIImage { .load(name: "profilelightblue2")}
    static var profileList: [UIImage] = [profileBlue3, profileBlue4, profileOrange1, profilePink1, profilePink3, profileOrange2, profileYellow2, profileIndigo3, profilePurple1, profilePurple2, profilePurple3, profileGreen1, profileYellow1, profileGreen3, profileLightBlue1, profileLightBlue2]
    
    // MARK: - button
    
    static var textFieldClearButton: UIImage { .load(name: "clearbutton")}
    static var navigationBarBackButton: UIImage { .load(name: "backbutton")}
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }
}
