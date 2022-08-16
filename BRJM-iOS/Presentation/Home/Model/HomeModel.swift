import Foundation


/**
 - Note: 홈 모델
 */
public class HomeModel: BaseModel {
    
    /** 카테고리 */
    public class Category {
        
        public var title: String = ""
        public var isSelected: Bool = false
    }
}
