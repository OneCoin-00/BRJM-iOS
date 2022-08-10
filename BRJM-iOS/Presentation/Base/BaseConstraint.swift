import UIKit


/**
 - Note: 앱에서 사용하는 상수 정의
 */
class BaseConstraint:NSObject {
    
    
    public static let APP_ID = ""
    
    /** Primary Color */
    public static let COLOR_PRIMARY:UIColor = UIColor(hex: "32a05f")
    public static let COLOR_RED:UIColor = UIColor(hex: "e35252")
    public static let COLOR_GREY:UIColor = UIColor(hex: "868686")
    public static let COLOR_RIGHT_GRAY:UIColor = UIColor(hex: "e5e5e5")
    
    /** Gray Color */
    public static let COLOR_GRAY_10:UIColor = UIColor(hex: "555555")
    public static let COLOR_GRAY_20:UIColor = UIColor(hex: "777777")
    public static let COLOR_GRAY_30:UIColor = UIColor(hex: "AAAAAA")
    public static let COLOR_GRAY_40:UIColor = UIColor(hex: "CCCCCC")
    public static let COLOR_GRAY_50:UIColor = UIColor(hex: "DDDDDD")
    public static let COLOR_GRAY_60:UIColor = UIColor(hex: "EEEEEE")
    public static let COLOR_GRAY_70:UIColor = UIColor(hex: "F7F7F7")
    public static let COLOR_GRAY_80:UIColor = UIColor(hex: "606060")
    
    public static let COLOR_BALCK_WITH_ALPHA1:UIColor = UIColor(hex: "000000").withAlphaComponent(0.01)
    public static let COLOR_BALCK_WITH_ALPHA60:UIColor = UIColor(hex: "000000").withAlphaComponent(0.6)

    /** 로그인 데이터 */
    public static let APP_PUSH_TOKEN = "APP_PUSH_TOKEN"/** 푸시 토큰 저장 키 */
    public static let APP_USER_ID = "APP_USER_ID"/** 로그인 아이디 */
    public static let APP_USER_AUTOLOGIN = "APP_USER_AUTOLOGIN"/** 자동 로그인 여부(true/false)*/
    
    // # 이미지 로드 시 페이드인 시간
    public static let IMAGE_FADEIN_DURATION:TimeInterval = 0.25
    
    /** rippleLayer */
    public static let RIPPLE_LAYER_ALPHA:CGFloat = 0.05
}
