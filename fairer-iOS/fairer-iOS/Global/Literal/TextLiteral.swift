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
    static let textFieldWarningOverFive: String = "텍스트는 5글자를 초과하여 입력하실 수 없어요."
    static let textFieldWarningOverTwenty: String = "텍스트는 20글자를 초과하여 입력하실 수 없어요."
    
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
    
    // MARK: - SettingHomeRuleViewController
    
    static let settingHomeRulePrimaryLabel: String = "하우스 규칙 설정"
    static let settingHomeRuleTextFieldLabel: String = "새로운 규칙"
    static let settingHomeRuleTextFieldPlaceholder: String = "예) 밥은 다 먹은 사람이 치우기"
    static let settingHomeRuleInfoLabel: String = "규칙은 최대 10개까지 만들 수 있습니다."
    
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
    
    // MARK: - HomeView
    
    static let homeViewAddWorkLabel: String = "집안일을 추가해 보세요!"
    static let homeViewFinishWorkTitle: String = "끝낸 집안일"
    
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
    
    // MARK: - SettingPolicyViewcController
    
    static let settingPolicyViewControllerPolicyContent = "fairer(이하 “회사”)은 회원이 fairer 서비스(이하 “서비스”)에 저장한 개인정보의 보호를 중요하게 생각하고, 회원의 개인정보를 보호하기 위하여 항상 최선을 다해 노력하고 있습니다. 본 개인정보처리방침은 2022년 6월 29일부터 효력을 가지며, 서비스가 수집하는 회원의 정보와 그 정보 수집 이유, 용도 및 회원의 콘텐츠를 처리하는 방법에 대한 설명입니다.\n\n1. 개인정보 수집항목 및 수집방법\n회사는 모든 회원에게 더 나은 서비스를 제공하기 위해 다음의 정보를 수집하고 저장합니다.\n\n① 회원이 제공하는 정보\n회원가입 시 가입에 필요한 정보를 아래와 같이 수집하고 있으며, 개인용 서비스와 기업용 서비스의 수집되는 항목은 아래와 같습니다.\n- 필수: 이메일, 비밀번호\n\n② 회원이 서비스를 사용할 때 수집하는 정보\n- 회원의 단말기(모바일, 컴퓨터) 정보, OS 종류 및 버전. 서비스 이용 기록, 국가, 언어, 프로그램 설치와 주요 기능 실행 등 사용량에 대한 기본 정보를 수집합니다.\n\n③ 서비스 이용 기록, 쿠키, 국가, 언어, 프로그램 설치와 주요 기능 실행 등 사용량에 대한 기본 정보를 수집합니다. 그 외에도 회원이 유료 서비스를 이용하는 과정에서 결제 등을 위하여 불가피하게 필요한 때에는 신용카드 정보 및 대금 청구 주소 등과 같이 결제에 필요한 거래 정보가 수집될 수 있습니다.\n\n④ 회원이 자신의 정보에 액세스하도록 허용하는 경우\n- 회원이 서비스에서 자신의 연락처에 액세스하도록 허용하는 경우, 서비스는 사용자가 차후 연락처를 이용할 수 있도록 서버에 연락처 정보를 저장합니다. 연락처 정보는 자료를 공유하거나 이메일을 보내거나 사람들에게 서비스에 초대하는 목적으로만 사용합니다.\n- 회원이 서비스에서 Google 또는 기타 서비스 제공업자의 회원 계정에 있는 정보에 액세스하도록 허용하는 경우, 서비스는 사용자가 차후 정보를 이용할 수 있도록 서비스 서버에 정보를 저장합니다.\n\n2. 개인정보 이용목적\n회사는 회원의 소중한 개인정보를 다음과 같은 목적으로만 이용하며, 목적이 변경될 경우에는 사전에 회원의 동의를 구하도록 하겠습니다.\n\n① 회원 가입 의사를 확인하고 계정을 생성하기 위하여 사용합니다.\n\n② 회원으로 가입한 이용자를 식별하고 불량회원의 부정 이용과 비인가 이용을 방지하기 위하여 사용합니다.\n\n③ 회원과 약속한 서비스를 제공하고 유료 서비스 구매 및 이용이 이루어지는 경우 이에 따른 요금 정산을 위해 사용됩니다.\n\n④ 서비스 내에서 회원 정보를 표시할 필요가 있는 경우(예: 공유된 문서의 작업자 정보 표시 등)에는 다른 회원에게 프로필 정보(예:이름, 이메일, 사진 등)를 표시할 수 있습니다.\n\n⑤ 회원에게 다양한 서비스를 제공하고 서비스 이용 과정에서 회원의 문의사항이나 불만을 처리하고 공지사항 등을 전달하기 위해 사용합니다.\n\n⑥ 회사는 회원가입 시 동의한 회원에 한하여 제품 및 마케팅 정보를 제공할 수 있습니다. 신규 서비스 개발, 이벤트 등 프로모션 정보 전달 및 광고 게재 시에 해당 정보를 이용합니다. 회원은 서비스 계정 설정의 이벤트, 서비스 안내에서 수신을 거부할 수 있습니다.\n\n⑦ 맞춤형 서비스 제공 및 신규 서비스 개발 등에 참고하기 위하여 이를 익명화하여, 이용 패턴과 접속빈도 분석 및 서비스 이용에 대한 통계에서도 사용됩니다.\n\n3. 개인정보 제3자 제공\n회사는 회원들의 개인정보를 '개인정보 이용목적'에서 고지한 범위내에서 사용하며, 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.\n\n① 회원이 사전에 동의한 경우\n- 이러한 경우에도, 회사는 이용자에게 개인정보를 받는 자, 그의 이용목적, 제공되는 개인정보의 항목, 개인정보의 보유 및 이용 기간을 사전에 고지하고 이에 대해 명시적•개별적으로 동의를 얻습니다.\n\n② 관련 법령에 특별한 규정이 있는 경우\n\n4. 개인정보 정정 및 회원탈퇴\n\n① 회원은 언제든지 등록된 회원의 개인정보를 열람하거나 정정할 수 있습니다.\n\n② 회원은 개인정보 수집 및 활용 관련 절과 조항에 명시된 바와 같이 회원가입 등을 통해 개인정보의 수집, 이용, 제공에 대해 동의한 내용을 언제든지 철회할 수 있습니다. 아래에 기재된 연락처의 개인정보관리책임자에게 서면, 전화, 이메일 등으로 연락하시면 바로 회원탈퇴를 위해 필요한 조치를 합니다. 동의 철회를 하고 개인정보를 파기하는 등의 조치를 한 경우에는 그 사실을 회원에게 지체 없이 통지하도록 하겠습니다.\n\n5. 개인정보 보유기간 및 이용기간\n회사는 이용자의 개인정보를 회원가입을 하는 시점부터 서비스를 제공하는 기간에만 제한적으로 이용하고 있습니다. 이용자가 (i) 회원탈퇴를 요청하거나 제공한 개인정보의 수집 및 이용에 대한 동의를 철회하는 경우, (ii) 수집 및 이용목적이 달성된 경우, (iii) 보유 및 이용기간이 종료된 경우 해당 이용자의 개인정보는 지체 없이 파기 됩니다.\n\n6. 개인정보 삭제 절차 및 방법\n이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 삭제됩니다.\n회사의 개인정보 삭제 절차 및 방법은 다음과 같습니다.\n\n① 파기절차\nA. 이용자가 회원가입 등을 위해 입력한 정보는 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 회사 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 삭제됩니다.\nB. 동 개인정보는 관련 법령에 의해 요구되는 경우 외에는 보유되는 이외의 다른 목적으로 이용되지 않습니다.\n\n② 파기방법\nA. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.\nB. 전자적 파일 형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.\n\n③ 전자상거래 등에서의 소비자 보호에 관한 법률, 전자금융거래법, 통신비밀보호법 등 법령에서 일정기간 정보의 보관을 규정하는 경우는 아래와 같습니다. 회사는 이 기간 동안 법령의 규정에 따라 개인정보를 보관하며, 본 정보를 다른 목적으로는 절대 이용하지 않습니다.\nA. 전자상거래 등에서 소비자 보호에 관한 법률\n- 계약 또는 청약철회 등에 관한 기록: 5년 보관\n- 대금결제 및 재화 등의 공급에 관한 기록: 5년 보관\n- 소비자의 불만 또는 분쟁처리에 관한 기록: 3년 보관\n B. 전자금융거래법\n- 전자금융에 관한 기록: 5년 보관\nC. 통신비밀보호법\n- 로그인 기록: 3개월\n\n7. 개인정보처리방침 변경\n회사는 관련 법률이나 서비스의 변경사항을 반영하기 위한 목적 등으로 개인정보처리방침을 수정할 수 있습니다. 현 개인정보처리방침 내용 추가, 삭제 및 수정이 있을 시에는 개정 최소 7일 전부터 홈페이지의 '공지사항' 또는 이메일 통해 알릴 것입니다. 다만, 개인정보의 수집 및 활용, 제3자 제공 등과 같이 이용자 권리의 중요한 변경이 있을 때는 최소 30일 전에 알립니다.\n\n8. 보안\n회사는 보유하는 정보에 대한 무단 액세스, 변경, 공개 또는 삭제로부터 서비스 및 서비스 사용자를 보호하기 위해 노력합니다.\n서비스상의 사용자 데이터에 액세스하려면 비밀번호가 필요하며 유료 결제 시 입력한 민감한 데이터(신용카드 정보 등)는 SSL 암호화로 보호됩니다.\n그러나 유선 또는 무선 인터넷은 100% 안전한 환경이 아니므로 귀하가 당사에 전송한 정보의 안전성을 보장할 수 없습니다. 따라서 회사에 의해 구현된 보안 절차에도 불구하고 당사의 물리적, 기술적 또는 경영상의 안전장치 중 어느 하나의 파괴 또는 침해로 인해 정보가 액세스, 공개, 변경 또는 파괴될 가능성이 없다고 보장하지 않습니다\n\n9. 추적 금지\n회사는 맞춤형 광고를 제공하기 위한 목적으로 고객을 일정 기간 및 제3자 웹 사이트에 걸쳐 추적하지 않으며, 이에 따라 추적 금지(DNT) 신호에 응답하지 않습니다.\n\n10. 이용자 및 법정대리인의 권리와 그 행사방법\n회원 및 법정 대리인은 언제든지 등록되어 있는 자신 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며, 회사의 개인정보의 처리에 동의하지 않는 경우 동의를 거부하거나 가입해지(회원탈퇴)를 요청하실 수 있습니다. 다만, 그러한 경우 서비스의 일부 또는 전부 이용이 어려울 수 있습니다.\n혹은 개인정보관리책임자에게 서면, 전화 또는 이메일로 연락하시면 지체 없이 조치하겠습니다.\n회원이 개인정보의 오류에 대한 정정을 요청하신 경우에는 정정을 완료하기 전까지 당해 개인정보를 이용 또는 제공하지 않습니다. 또한 잘못된 개인정보를 제3 자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.\n회사는 회원 혹은 법정 대리인의 요청에 의해 해지 또는 삭제된 개인정보는 '5. 개인정보의 보유 및 이용기간'에 명시된 바에 따라 처리하고 그 외의 용도로 열람 또는 이용할 수 없도록 처리하고 있습니다.\n\n11. 개인정보에 관한 민원서비스\n개인정보 보호에 관한 질문이나 문의가 있는 경우 또는 고객 지원이 필요한 경우 아래에 기재된 연락처로 문의해 주시기 바랍니다.\n\n▶ 개인정보보호책임자\n- 성명 : 김유나\n- 직위 : 개발자\n- 연락처 : 010-8033-1076\n\n귀하께서는 회사의 서비스를 이용하시며 발생하는 모든 개인정보보호 관련 민원을 개인정보관리책임자 혹은 담당 부서로 신고하실 수 있습니다. 회사는 이용자들의 신고사항에 대해 신속하게 충분한 답변을 드릴 것입니다.\n\n공고 일자: 2023년 1월 2일\n시행 일자: 2022년 1월 10일\n\n부칙\n본 개인정보처리방침은 각 국가별로 법률의 요구사항에 따라 언어별로 상이할 수 있습니다. 각 언어별 개인정보처리방침의 내용이 서로 충돌하는 경우에는 그 지역의 언어로 작성된 개인정보처리방침이 우선 적용되며, 그 지역의 언어로 작성된 개인정보처리방침이 없을 경우에는 영어로 작성된 개인정보처리방침이 적용됩니다. 한국어로 작성된 개인정보처리방침은 대한민국에서만 적용됩니다."
    static let settingPolicyViewControllerNavigationBarTitle = "정보"
    
    // MARK: - SelectHouseWorkViewController
    
    static let selectHouseWorkViewControllerInfoLabel = "공간을 선택하면 세부 집안일이 나옵니다."
    static let selectHouseWorkViewControllerNextButtonText = "다음"
    static let selectHouseWorkViewControllerDetailHouseWorkLabel = "세부 집안일"
    static let selectHouseWorkViewControllerWriteHouseWorkLabel = "원하는 집안일이 없나요?"
    static let selectHouseWorkViewControllerAlertTitle = "같은 공간만 선택 할 수 있어요"
    static let selectHouseWorkViewControllerAlertMessage = "다른 공간을 선택하시면 선택한 집안일이\n삭제 됩니다. 다른 공간을 선택하시겠어요?"
    
    // MARK: - WriteHouseWorkButton
    
    static let writeHouseWorkButtonLabel = "집안일 직접 입력하기"
    
    // MARK: - SetHouseWorkCollectionViewCell
    
    static let setHouseWorkCollectionViewCellDefaultTimeLabel = "하루 종일"
    static let setHouseWorkManagerToastLabel = "집안일 담당자를 지정해주세요."
    
    // MARK: - SelectManagerView
    
    static let selectManagerViewLabel = "집안일 담당자 선택"
    static let selectManagerViewCancelButtonText = "취소"
    static let selectManagerViewConfirmButtonText = "확인"
    
    // MARK: - GetManagerView
    
    static let getManagerViewManagerLabel = "담당자"
    
    // MARK: - RepeatCycleView
    
    static let repeatCycleViewRepeatCycleLabel = "반복주기"
    
    // MARK: - RepeatCycleCollectionView
    
    static let repeatCycleCollectionViewDaysOfWeekList = ["0월", "1화", "2수", "3목", "4금", "5토", "6일"]
    
    // MARK: - SetHouseWorkViewController
    
    static let setHouseWorkViewControllerSetTimeLabel = "시간설정"
    static let setHouseWorkViewControllerSetRepeatLabel = "반복하기"
    static let setHouseWorkViewControllerDoneButtonText = "집안일 추가 완료"
    static let setHouseWorkViewControllerEveryWeek = "매주 "
    static let setHouseWorkViewControllerWeek = "요일"
    static let setHouseWorkViewControllerEveryMonth = "매달 "
    static let setHouseWorkViewControllerDay = "일"
    static let setHouseWorkViewControllerRepeat = "에 반복해요"
    
    
    // MARK: - WriteHouseWorkViewController
    
    static let writeHouseWorkViewControllerHouseWorkNameLabel = "집안일 이름"
    static let writeHouseWorkViewControllerHouseWorkNameTextFieldPlaceholderText = "직접 입력"
    static let writeHouseWorkViewControllerHouseWorkNameWarningLabel = "텍스트는 16글자를 초과하여 입력하실 수 없어요."
    
    // MARK: - SettingProfileViewController
    
    static let settingProfileViewControllerTitleLabel = "프로필을 설정해주세요."
    static let settingProfileViewControllerProfileNameLabel = "이름"
    static let settingProfileViewControllerProfileStatusLabel = "상태 메세지"
}
