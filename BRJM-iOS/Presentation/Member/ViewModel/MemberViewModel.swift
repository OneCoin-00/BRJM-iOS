import Foundation


/**
 - Note: 사용자 뷰 모델
 */
class MemberViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: MemberModel) -> Void
    public var _callback: ResponseCallback?
}

extension MemberViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
}
