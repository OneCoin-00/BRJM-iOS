import UIKit


/**
 - Note: ViewController 파라미터 전달
 */
class Session: NSObject {
    
    fileprivate static let _shared = Session()
    
    class func shared() -> Session {
        return _shared
    }
    
    struct viewParams {
        static var items:[String:Any] = [:]
    }
    
    override init() {
    }
    
    /** 전달할 파라미터 */
    func setParams(param: [String:Any]) {
        viewParams.items = [:]
        viewParams.items = param
    }
    
    /** 전달된 파라미터 */
    func getParams() -> [String:Any] {
        return viewParams.items
    }
    
    func clear() {
        viewParams.items = [:]
    }
}
