import Foundation


/**
 - Note: CoverViewModel
 */
class CoverViewModel: NSObject {
    
    typealias ResponseCallback = (_ response: VersionModel) -> Void
    public var _callback: ResponseCallback?
}

extension CoverViewModel {
    
    public func versionCompletion(callBack: @escaping ResponseCallback) {
        _callback = callBack
    }
    
    public func requestVersion() {
        
        /*
        DataLoadUtils.shared().requestVersion() { response in
            
            if let callback = self._callback {
                
                callback(response)
            }
        }
         */
    }
}
