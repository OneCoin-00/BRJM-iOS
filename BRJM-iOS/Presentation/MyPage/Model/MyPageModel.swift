import Foundation


/**
 - Note: 마이페이지 모델
 */
class MyPageModel: BaseModel {

    public var alertList:[Alert] = []/** 알림 리스트 */
    
    /** 알림 */
    public class Alert {
        
        public var title: String = ""/** 타이틀 */
        public var isSee: Bool = false/** 확인 여부 */
    }
}
