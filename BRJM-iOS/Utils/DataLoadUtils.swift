import Foundation
import UIKit
import SwiftyJSON
import SwiftyUserDefaults
import Alamofire


/**
 - Note: API 요청 관리
 */
class DataLoadUtils {
    
    private static var _shared: DataLoadUtils = {
        
        let obj = DataLoadUtils(/*parameta*/)
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> DataLoadUtils {
        return _shared
    }
    
}
