import Foundation


/**
 - Note: 마이페이지 뷰 모델
 */
class MyPageViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: MyPageModel) -> Void
    public var _callback: ResponseCallback?
}

extension MyPageViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}
