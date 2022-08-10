import Foundation


/**
 - Note: 게시판 뷰 모델
 */
class BoardViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: BaseModel) -> Void
    public var _callback: ResponseCallback?
}

extension BoardViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}

