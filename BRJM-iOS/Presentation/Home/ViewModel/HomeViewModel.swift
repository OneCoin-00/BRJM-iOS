import Foundation


/**
 - Note: 
 */
class HomeViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: HomeModel) -> Void
    public var _callback: ResponseCallback?
}

extension HomeViewModel {
    
    public func requestCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
    
    public func requestData(userSeq: String = "") {
        
        /*
        DataLoadUtils.shared().requestWithHome(userSeq: userSeq) { response in
            
            if let callback = self._callback {
                
                callback(response)
            }
        }
        */
    }
}
