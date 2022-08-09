import Foundation
import UIKit


/**
 - Note: 네트워크 설정
 */
class NetworkDefine {
    
    private static var _shared: NetworkDefine = {
        
        let obj = NetworkDefine(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> NetworkDefine {
        return _shared
    }
    
    
    
    
    //--------------------------------------------------
    #if DEBUG
    /** 개발 */
    // public static let API_HOST = "http://192.168.50.187:8080"/** 로컬 서버 */
    public static let API_HOST = "https://dev-sdn-api.hiconsysvc.com"/** 개발 서버 */
    public static let WEB_HOST = "http://m.google.com"
    #else
    /** 운영 */
    public static let API_HOST = "https://dev-sdn-api.hiconsysvc.com"/** 운영 서버 */
    public static let WEB_HOST = "http://m.google.com"
    #endif
    
    
    @discardableResult
    public static func apiHost() -> String {
        return NetworkDefine.API_HOST
    }
    
    @discardableResult
    public static func webHost() -> String {
        return NetworkDefine.WEB_HOST
    }
    
    
    //--------------------------------------------------
    public static let API_VERSION_CHECK = ""
    public static let API_APP_LOGIN = "/api/app/login"/** 앱 로그인 */
   
}
