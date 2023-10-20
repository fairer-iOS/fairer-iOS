//
//  ImageLiteral.swift
//  fairer-iOS
//
//  Created by Mingwan Choi on 2022/09/10.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - image
    
    static var imgInfo: UIImage { .load(systemName: "info.circle.fill") }
    static var imgLogo: UIImage { .load(name: "fairerlogo") }
    static var imgHomeLogo: UIImage { .load(name: "fairerlogoInHomeVC")}
    static var imgLogoLogin: UIImage { .load(name: "fairerlogologin") }
    static var imgLogoSplash: UIImage { .load(name: "fairerlogosplash") }
    static var imgAppleLogo: UIImage { .load(name: "applelogo") }
    static var imgGoogleLogo: UIImage { .load(name: "googlelogo") }
    static var imgEntrance: UIImage { .load(name: "entrance") }
    static var imgBathroom: UIImage { .load(name: "bathroom") }
    static var imgKitchen: UIImage { .load(name: "kitchen") }
    static var imgLivingRoom: UIImage { .load(name: "livingRoom") }
    static var imgOutside: UIImage { .load(name: "outside") }
    static var imgRoom: UIImage { .load(name: "room") }
    static var imgSelectedEntrance: UIImage { .load(name: "selectedEntrance") }
    static var imgSelectedBathroom: UIImage { .load(name: "selectedBathroom") }
    static var imgSelectedKitchen: UIImage { .load(name: "selectedKitchen") }
    static var imgSelectedLivingRoom: UIImage { .load(name: "selectedLivingRoom") }
    static var imgSelectedOutside: UIImage { .load(name: "selectedOutside") }
    static var imgSelectedRoom: UIImage { .load(name: "selectedRoom") }
    static var imgCopyCode: UIImage { .load(name: "copycode") }
    static var imgKakaoShare: UIImage { .load(name: "kakaoshare") }
    static var imgWelcomeHouse: UIImage { .load(name: "welcomehouse") }
    static var imgAlreadyHouse: UIImage { .load(name: "alreadyhouse") }
    static var imgBubble: UIImage { .load(name: "bubble") }
    static var imgUnion: UIImage { .load(name: "Union") }
    
    
    // MARK: - profile
    
    static var profileNone: UIImage { .load(name: "profilenone") }
    static var profileBlue3: UIImage { .load(name: "profileblue3") }
    static var profileBlue4: UIImage { .load(name: "profileblue4") }
    static var profileOrange1: UIImage { .load(name: "profileorange1") }
    static var profilePink1: UIImage { .load(name: "profilepink1") }
    static var profilePink3: UIImage { .load(name: "profilepink3") }
    static var profileOrange2: UIImage { .load(name: "profileorange2") }
    static var profileYellow2: UIImage { .load(name: "profileyellow2") }
    static var profileIndigo3: UIImage { .load(name: "profileindigo3") }
    static var profilePurple1: UIImage { .load(name: "profilepurple1") }
    static var profilePurple2: UIImage { .load(name: "profilepurple2") }
    static var profilePurple3: UIImage { .load(name: "profilepurple3") }
    static var profileGreen1: UIImage { .load(name: "profilegreen1") }
    static var profileYellow1: UIImage { .load(name: "profileyellow1") }
    static var profileGreen3: UIImage { .load(name: "profilegreen3") }
    static var profileLightBlue1: UIImage { .load(name: "profilelightblue1") }
    static var profileLightBlue2: UIImage { .load(name: "profilelightblue2") }
    static var profileList: [UIImage] = [profileBlue3, profileBlue4, profileOrange1, profilePink1, profilePink3, profileOrange2, profileYellow2, profileIndigo3, profilePurple1, profilePurple2, profilePurple3, profileGreen1, profileYellow1, profileGreen3, profileLightBlue1, profileLightBlue2]
    
    // MARK: - profile selected
    
    static var profilelightblue1Selected: UIImage { .load(name: "profilelightblue1Selected") }
    
    // MARK: - button
    
    static var textFieldClearButton: UIImage { .load(name: "clearbutton") }
    static var smallClearButton: UIImage { .load(name: "smallClearButton")}
    static var navigationBarBackButton: UIImage { .load(name: "backbutton") }
    static var settingProfileImageBrushButton: UIImage { .load(name: "brushButton") }
    static var plusWorkButton: UIImage { .load(systemName: "plus") }
    static var moveToCalendarButton: UIImage { .load(name: "keyboard_arrow_down") }
    static var addManagerButton: UIImage { .load(name: "managerplus") }
    static var repeatCycleChevronButton: UIImage { .load(name: "repeatcyclechevron") }
    static var repeatAlertSelectedButton: UIImage { .load(systemName: "circle.circle.fill") }
    static var repeatAlertDeSelectedButton: UIImage { .load(systemName: "circle")}
    
    // MARK: - icon
    
    static var settingProfile: UIImage { .load(systemName: "person.circle.fill") }
    static var settingChevron: UIImage { .load(name: "settingchevron") }
    static var settingPeople: UIImage { .load(systemName: "person.2.fill") }
    static var settingBell: UIImage { .load(systemName: "bell.fill") }
    static var settingExclamation: UIImage { .load(systemName: "exclamationmark.circle") }
    static var settingInfo: UIImage { .load(systemName: "info.circle") }
    static var calendarChevron: UIImage { .load(name: "calendarchevron") }
    static var writeHouseWorkChevron: UIImage { .load(systemName: "chevron.right") }
    static var spacePin: UIImage { .load(name: "pin") }
    static var deleteButton: UIImage { .load(systemName: "xmark.circle.fill") }
    static var selectManager: UIImage { .load(systemName: "checkmark.circle.fill") }
    static var deselectManager: UIImage { .load(systemName: "circle") }
    static var settingMenu: UIImage { .load(name: "menu") }
    static var selectedCalendarCell: UIImage { .load(name: "selectedCell") }
    static var locationPin: UIImage { .load(name: "locationPin") }
    static var houseFill: UIImage { .load(systemName: "house.fill") }
    static var error: UIImage { .load(name: "error") }
    static var homeIcon: UIImage { .load(name: "home") }
    static var pencil: UIImage { .load(systemName: "pencil") }
    static var trash: UIImage { .load(systemName: "trash") }
    static var hurry: UIImage { .load(systemName: "megaphone.fill") }
    
    // MARK: - dot
    
    static var oneDot: UIImage { .load(name: "dot") }
    static var twoDots: UIImage { .load(name: "2dot") }
    static var threeDots: UIImage { .load(name: "3dot") }
    
    // MARK: - exception handling
    
    static var emptyHouseWork: UIImage { .load(name: "emptyHouseWork") }
    static var networkError: UIImage { .load(name: "networkError") }
    
    // MARK: - emojis
    
    static var emojiAngry: UIImage { .load(name: "angry") }
    static var emojiSad: UIImage { .load(name: "sad") }
    static var emojiSmile: UIImage { .load(name: "smile") }
    static var emojiHappy: UIImage { .load(name: "happy") }
    static var emojiHeart: UIImage { .load(name: "heart") }
    static var emojiPerfect: UIImage { .load(name: "perfect") }
    static var emojiBlue: UIImage { .load(name: "blue") }
    static var emojiList: [UIImage] = [emojiAngry, emojiSad, emojiSmile, emojiHappy, emojiHeart, emojiPerfect, emojiBlue]
    
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
