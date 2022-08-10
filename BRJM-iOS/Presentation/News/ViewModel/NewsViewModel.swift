import Foundation


/**
 - Note: 환경 소식 뷰 모델
 */
class NewsViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: NewsModel) -> Void
    public var _callback: ResponseCallback?
}

extension NewsViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}
