import Foundation


/**
 - Note: Enum
 */
struct Enum {
    
    /** 홈 탭 */
    enum TabBarType {
        case home                       /** 홈 */
        case board                      /** 게시판 */
        case write                      /** 글쓰기 */
        case news                       /** 환경소식 */
        case mypage                     /** 마이페이지 */
    }
    
    /** 카테고리 */
    enum Category: String {
        case life = "생활"
        case energy = "에너지 절약"
        case diy = "DIY"
        case dress = "옷"
        case furniture = "가구"
        case plant = "식물"
        case prop = "소품"
        case beauty = "뷰티"
    }
}
