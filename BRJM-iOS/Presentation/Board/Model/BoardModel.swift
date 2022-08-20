import Foundation


/**
 - Note: 게시판 모델
 */
class BoardModel: BaseModel {

    public class Post {
        
        public var title: String = ""
        public var writer: String = ""
        public var views: String = ""
        public var likes: String = ""
        public var imageURL: String = ""
        public var isLiked: Bool = false
    }
}
