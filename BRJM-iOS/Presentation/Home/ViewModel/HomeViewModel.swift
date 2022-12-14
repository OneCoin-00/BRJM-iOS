import Foundation


/**
 - Note: 홈 뷰 모델
 */
class HomeViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: BaseModel) -> Void
    public var _callback: ResponseCallback?
}

extension HomeViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}
