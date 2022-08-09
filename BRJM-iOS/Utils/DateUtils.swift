import Foundation
import UIKit
import SwiftyUserDefaults


class DateUtils {
    
    private static var _shared: DateUtils = {
        
        let obj = DateUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> DateUtils {
        return _shared
    }
    
    public func yyyymmddHHmmssToDate(date:String) -> Date {
        CommonUtils.log("yyyymmddHHmmssToDate \(date)")
        
        if date.count == 0 { return Date() }
        
        let dateFormatter:DateFormatter! = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: date) ?? Date()
    }
    
    public func yyyymmdd(date:Date) -> String {
        
        let dateFormatter:DateFormatter! = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
    
    public func stringToString(date:String, from:String, to: String) -> String {
        if date.count == 0 { return "" }
        
        var newDate = Date()
        
        let dateFormatter1:DateFormatter! = DateFormatter()
        dateFormatter1.dateFormat = from
        newDate = dateFormatter1.date(from: date)!
        
        let dateFormatter2:DateFormatter! = DateFormatter()
        dateFormatter2.dateFormat = to
        return dateFormatter2.string(from: newDate)
    }
}
