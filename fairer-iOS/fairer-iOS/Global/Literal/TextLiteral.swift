//
//  TextLiteral.swift
//  fairer-iOS
//
//  Created by 김유나 on 2022/09/19.
//

import UIKit

enum TextLiteral {
    
    // MARK: - AnyWhere
    
    static let doneButtonText: String = "입력 완료"
    static let textFieldDisableSignLabel: String = "&,!,#,@,^와 같은 특수문자는 입력하실 수 없어요."
    
    // MARK: - OnboardingNameViewController
    
    static let onboardingNameViewControllerNameLabel: String = "이름을 입력해주세요."
    static let onboardingNameViewControllerTextFieldPlaceholder: String = "예) 홍길동"
    
    // MARK: - OnboardingProfileViewController
    
    static let onboardingProfileViewControllerProfileLabel: String = "프로필 사진을 골라주세요."
    static let onboardingProfileViewControllerCollectionViewLabel: String = "기본 프로필 선택"
    static let onboardingProfileViewControllerDoneButtonText: String = "선택 완료"
    
    // MARK: - HomeRuleView
    
    static let homeRuleViewRuleLabel: String = "규칙"
    static let homeRuleViewRuleDescriptionLabel: String = "여기를 눌러 하우스의 규칙을 입력해주세요!"
    
    // MARK: - HouseMakeNameViewController
    
    static let houseMakeNameViewControllerWriteNamePrimaryLabel: String = "하우스의 이름을 입력해주세요."
    static let houseMakeNameViewControllerWriteNameSecondaryLabel: String = "집의 특성을 잘 보여줄 수 있는 이름도 좋아요!"
    static let houseMakeNameViewControllerTextFieldPlaceholder: String = "예) 즐거운 우리집"

    // MARK: - GroupMainViewController
    
    static let groupMainViewControllerHouseMakeLabel: String = "집안일 하우스 생성"
    static let groupMainViewControllerHouseMakeButtonText: String = "집안일 하우스 만들기"
    static let groupMainViewControllerHouseMakeInfoLabel: String = "개인 혹은 여러명이 집안일을 관리할 수 있는 하우스를\n만들 수 있습니다."
    static let groupMainViewControllerHouseEnterLabel: String = "하우스 참여"
    static let groupMainViewControllerHouseEnterButtonText: String = "집안일 하우스 참여하기"
    static let groupMainViewControllerHouseEnterInfoLabel: String = "기존에 만들어진 하우스에 참여하고 싶다면\n선택해주세요."
    
    // MARK: - HomeCalendarView
    
    static let homeCalendarViewTodayTitle: String = "오늘"
    
    // MARK: - HouseInviteCodeViewController
    
    static let houseInviteCodeViewControllerPrimaryLabel: String = "하우스에 사람을 초대해주세요."
    static let houseInviteCodeViewControllerSecondaryLabel: String = "앞으로 함께 집안일을 관리할 가족, 친구, 룸메이트\n누구든 초대해주세요!"
    static let houseInviteCodeViewControllerInviteCodeLabel: String = "의 초대코드"
    static let houseInviteCodeViewControllerValidTimeLabel: String = "까지 유효한 코드"
    static let houseInviteCodeViewControllerCodeInfoLabel: String = "초대 받은 사람은 해당 초대코드가 생성된 24시간 안에\n입력하셔야 합니다."
    static let houseInviteCodeViewControllerCopyCodeButtonText: String = "코드 복사하기"
    static let houseInviteCodeViewControllerKakaoShareButtonText: String = "카카오톡 공유하기"
    static let houseInviteCodeViewControllerSkipButtonText: String = "건너뛰기"
    static let houseInviteCodeViewControllerCopyCodeToastLabel: String = "코드를 클립보드에 복사했습니다."
    static let houseInviteCodeViewControllerRefreshButtonText: String = "코드 재발급 받기"
    
    // MARK: - EnterHouseViewController
    
    static let enterHouseViewControllerPrimaryLabel: String = "초대코드를 입력해주세요."
    static let enterHouseViewControllerSecondaryLabel: String = "초대코드를 입력 후 바로 공간에 참여할 수 있어요!"
    static let enterHouseViewControllerTextfieldPlaceHolder: String = "12글자 입력"
    static let enterHouseViewControllerToastWrongCode: String = "잘못된 코드입니다."
    static let enterHouseViewControllerToastHouseFull: String = "하우스가 꽉 차서 참여할 수 없어요.\n6명까지만 참여할 수 있어요."
    
    // MARK: - HouseInfoViewController
    
    static let houseInfoViewControllerWelcomeLabel: String = "에 어서오세요!"
    static let houseInfoViewControllerHouseMemberLabel: String = "공간 참여자"
    static let houseInfoViewControllerHouseInfoDoneButtonText: String = "참여 완료"
    
    // MARK: - AlreadyInGroupViewController
    
    static let alreadyInGroupViewControllerTitleLabel: String = "이미 그룹에 참여되어 있습니다.\n새로운 그룹에 참여하려면\n기존의 그룹에서 나가주세요."
    static let alreadyInGroupViewControllerInfoLabel: String = "기존의 그룹에서 나가는 경로는\n’설정>그룹 관리>그룹에서 나가기’ 입니다."
    static let alreadyInGroupViewControllerDoneButtonText: String = "메인으로 돌아가기"
    
    // MARK: - SettingViewController
    
    static let settingViewControllerNavigationBarTitleLabel: String = "설정"
    static let settingViewControllerTableViewCellLabelList: [String] = ["계정", "하우스 관리", "알림", "문의하기", "정보"]
    static let settingViewControllerVersionLabel: String = "버전"
    static let settingViewControllerVersionText: String = "0.0.1"
    static let settingViewControllerLogoutButtonText: String = "로그아웃"
    
    // MARK: - ManageHouseViewController
    
    static let manageHouseViewControllerTableViewCellLabelList: [String] = ["하우스 이름 변경", "초대하기"]
    static let manageHouseViewControllerLeaveHouseButtonText: String = "하우스에서 나가기"
    static let manageHouseViewControllerDifferentHouseButtonText: String = "다른 공간에 참여하고 싶다면?"
    static let manageHouseViewControllerBubbleText = "‘공간에서 나가기'를 하셔야만\n다른 공간에 참여하실 수 있습니다."
    static let manageHouseViewControllerAlertTitle: String = "정말 나가시겠습니까?"
    static let manageHouseViewControllerAlertMessage: String = "모든 집안일 기록이 사라집니다."
    static let manageHouseViewControllerAlertOkTitle: String = "나가기"
    static let manageHouseViewControllerAlertCancelTitle: String = "취소"
    
    // MARK: - ChangeHouseNameViewController
    
    static let changeHouseNameViewControllerTitleLabel: String = "하우스의 이름을 입력해주세요."
    static let changeHouseNameViewControllerSecondaryLabel: String = "집의 특성을 잘 보여줄 수 있는 이름도 좋아요!"
    static let changeHouseNameViewControllerDoneButtonText: String = "입력 완료"
    
    // MARK: - SettingAlarmViewController
    
    static let settingAlarmViewControllerTimeAlarmCellText = "설정 시간에 맞춰 집안일 알림"
    static let settingAlarmViewControllerRemindAlarmCellText = "미완료 집안일 리마인드"
    static let settingAlarmViewControllerMorningAlarmCellText = "기본 아침 알림"
    
    // MARK: - SettingInquiryViewController
    
    static let settingInquiryViewControllerTitleLabel = "궁금한 점이 있으시다면\n아래 연락처를 통해 문의해주세요."
    static let settingInquiryViewControllerMailSubjectText = "[문의] "
    static let settingInquiryViewControllerMailBodyText = "문의 내용"
    static let settingInquiryViewControllerAlertTitle = "Mail 앱 연결 실패"
    static let settingInquiryViewControllerAlertMessage = "이메일 설정을 확인하고 다시 시도해주세요."
}
