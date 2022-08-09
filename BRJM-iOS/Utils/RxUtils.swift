import Foundation
import SwiftyUserDefaults
import SwiftyJSON
import RxSwift
import RxCocoa


/**
 - Global Rx 유틸리티
 */
class RxUtils {
    
    private static var _shared: RxUtils = {
        
        let obj = RxUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> RxUtils {
        return _shared
    }
    
    /** Rx DisposeBag */
    public var disposeBag = DisposeBag()
    
}
