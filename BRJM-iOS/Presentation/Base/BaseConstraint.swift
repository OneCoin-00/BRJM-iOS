import UIKit


/**
 - Note: 앱에서 사용하는 상수 정의
 */
class BaseConstraint:NSObject {
    
    
    public static let APP_ID = ""
    
    
    /** Primary Color */
    public static let COLOR_PRIMARY:UIColor = UIColor(hex: "1E6CFB")
    public static let COLOR_ACTIVE:UIColor = UIColor(hex: "0067BC")
    
    /** Sub Color */
    public static let COLOR_BLUE:UIColor = UIColor(hex: "1DC7E2")
    public static let COLOR_GREEN:UIColor = UIColor(hex: "30E7C0")
    public static let COLOR_YELLOW:UIColor = UIColor(hex: "FFDB40")
    public static let COLOR_ORANGE:UIColor = UIColor(hex: "FF8B37")
    public static let COLOR_PURPLE:UIColor = UIColor(hex: "3B149E")
    public static let COLOR_RED:UIColor = UIColor(hex: "F81826")
    
    /** Gray Color */
    public static let COLOR_GRAY_00:UIColor = UIColor(hex: "000000")
    public static let COLOR_GRAY_10:UIColor = UIColor(hex: "555555")
    public static let COLOR_GRAY_20:UIColor = UIColor(hex: "777777")
    public static let COLOR_GRAY_30:UIColor = UIColor(hex: "AAAAAA")
    public static let COLOR_GRAY_40:UIColor = UIColor(hex: "CCCCCC")
    public static let COLOR_GRAY_50:UIColor = UIColor(hex: "DDDDDD")
    public static let COLOR_GRAY_60:UIColor = UIColor(hex: "EEEEEE")
    public static let COLOR_GRAY_70:UIColor = UIColor(hex: "F7F7F7")
    
    /** Disabled Color */
    // public static let COLOR_GRAY_40:UIColor = UIColor(hex: "CCCCCC")
    
    /** Border Color */
    // public static let COLOR_GRAY_00:UIColor = UIColor(hex: "000000")
    // public static let COLOR_GRAY_50:UIColor = UIColor(hex: "DDDDDD")
    // public static let COLOR_GRAY_60:UIColor = UIColor(hex: "EEEEEE")
    
    /** Error Color */
    // public static let COLOR_RED:UIColor = UIColor(hex: "F81826")
    
    
    /** 로그인 데이터 */
    public static let APP_PUSH_TOKEN = "APP_PUSH_TOKEN"/** 푸시 토큰 저장 키 */
    public static let APP_USER_ID = "APP_USER_ID"/** 로그인 아이디 */
    public static let APP_USER_AUTOLOGIN = "APP_USER_AUTOLOGIN"/** 자동 로그인 여부(true/false)*/
    
    // # 이미지 로드 시 페이드인 시간
    public static let IMAGE_FADEIN_DURATION:TimeInterval = 0.25
}
