import Foundation


/**
 - Note: 글쓰기 뷰 모델
 */
class WriteViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: BaseModel) -> Void
    public var _callback: ResponseCallback?
}

extension WriteViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}
