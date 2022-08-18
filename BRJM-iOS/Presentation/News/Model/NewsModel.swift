import Foundation


/**
 - Note: 환경소식 모델
 */
class NewsModel: BaseModel {

    public var newsList:[News] = []/** 환경소식 리스트 */
    
    /** 환경소식 */
    public class News {
        
        public var title: String = ""/** 제목 */
        public var url: String = ""/** url */
    }
}
