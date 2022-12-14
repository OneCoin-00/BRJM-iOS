import Foundation


/**
 - Note: 게시판 모델
 */
class BoardModel: BaseModel {

    public var postList:[Post] = []/** 게시글 리스트 */
    
    /** 게시글 */
    public class Post {
        
        public var title: String = ""
        public var description: String = ""
        public var writer: String = ""
        public var views: String = ""
        public var likes: String = ""
        public var imageURL: String = ""
        public var isLiked: Bool = false
    }
    
    /** 최근 검색어 */
    public class History {
        
        public var userSeq: String = ""/** SEQ */
        public var searchText: String = ""/** 최근 검색어 */
    }
}
