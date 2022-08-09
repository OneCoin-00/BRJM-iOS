import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

/**
 * 공통 HTTP 요청
 */
open class CommonRequest: NSObject {

    /*
     CCM10001    서버 오류가 발생하였습니다. 이전 화면으로 돌아가거나 앱을 다시 실행해 주세요.
     CCM10002    정상 처리되었습니다.
    */
    public static let NET_MSG_00000:String = "NET_MSG_00000"
    public static let API_MSG_10001:String = "API_MSG_10001"
    public static let API_MSG_10002:String = "API_MSG_10002"
    
    enum NetworkError: Error {
        case notConnected
        case noResponse
    }
    
    static let shared = CommonRequest()
    
    
    /** 공통 요청 파라미터 */
    public func getParams() -> [String:Any] {
        
        
        var params:[String:Any] = ["appPack":"com.hiconsy.app.jj"]
        params["osType"] = "IOS"
        params["osVer"] = CommonUtils.getOSVersion()
        params["appVer"] = CommonUtils.getVersion()
        params["model"] = ""
        
        if let token = Defaults.defaults.string(forKey: BaseConstraint.APP_PUSH_TOKEN) {
            params["appToken"] = token
        }
        
        // params["userId"] = Defaults.string(forKey: BaseConst.SPC_USER_CODE)
        
        return params
    }
    
    
    /**
     - Note: POST
     */
    public func requestPOST(_ path:String, params:[String : Any], completion: @escaping (_ result: JSON) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(JSON(["result":false, "code":CommonRequest.NET_MSG_00000]))
            return
        }
        
        let headers:HTTPHeaders = ["Content-Type": "application/json",
                                   "Accept-Charset": "charset=UTF-8"]
        
        
        AF.request(path, method: .post, parameters: params, encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            
            #if DEBUG
            debugPrint(response)
            #endif
            
            switch response.result {
            case .success(let data):
                completion( JSON(data) )
                break
            case .failure(let error):
                
                #if DEBUG
                print(error)
                #endif
                
                completion(JSON(["result":false, "statusCode":error.responseCode, "code":CommonRequest.API_MSG_10001, "message":"service_error".localized()]))
            }
        }
    }
    
    /**
     - Note: GET
     */
    public func requestGET(_ path:String, params:[String : Any], completion: @escaping (_ result: JSON) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(JSON(["result":false, "code":CommonRequest.NET_MSG_00000]))
            return
        }
        
        let headers:HTTPHeaders = ["Accept-Charset": "charset=UTF-8"]
        
        /** 한글 URL 처리 */
        let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        AF.request(url.absoluteString, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).validate(statusCode: 200..<300).responseJSON { response in
            
            /** AFDataResponse<Any> */
            
            #if DEBUG
            debugPrint(response)
            #endif

            switch response.result {
            case .success(let data):
                
                if String(describing: data).contains("error") {
                    
                    #if DEBUG
                    print("An error has occurred.")
                    #endif
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                let result = JSON(data)["statusCode"].intValue
                
                if result != 200 {
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "statusCode":result, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                completion( JSON(data) )
                break
            case .failure(let error):
                
                #if DEBUG
                print(error)
                #endif
                
                completion(JSON(["result":false, "statusCode":error.responseCode, "code":CommonRequest.API_MSG_10001, "message":"service_error".localized()]))
                
                // RxUtils.shared().networkObservable.onNext(error.responseCode ?? -1)
            }
            
        }
    }
    
    
    /**
     - Note: PUT
     */
    public func requestPUT(_ path:String, params:[String : Any], completion: @escaping (_ result: JSON) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(JSON(["result":false, "code":CommonRequest.NET_MSG_00000]))
            return
        }
        
        let headers:HTTPHeaders = ["Content-Type": "application/json",
                                   "Accept-Charset": "charset=UTF-8"]
        
        
        AF.request(path, method: .put, parameters: params, encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            
            #if DEBUG
            debugPrint(response)
            #endif
            
            switch response.result {
            case .success(let data):
                completion( JSON(data) )
                break
            case .failure(let error):
                
                #if DEBUG
                print(error)
                #endif
                
                completion(JSON(["result":false, "statusCode":error.responseCode, "code":CommonRequest.API_MSG_10001, "message":"service_error".localized()]))
            }
        }
    }
    
    
    /**
     - Note: DELETE
     */
    public func requestDELETE(_ path:String, params:[String : Any], completion: @escaping (_ result: JSON) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(JSON(["result":false, "code":CommonRequest.NET_MSG_00000]))
            return
        }
        
        let headers:HTTPHeaders = ["Accept-Charset": "charset=UTF-8"]
        
        /** 한글 URL 처리 */
        let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        AF.request(url.absoluteString, method: .delete, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            
            /** AFDataResponse<Any> */
            
            #if DEBUG
            debugPrint(response)
            #endif

            switch response.result {
            case .success(let data):
                
                if String(describing: data).contains("error") {
                    
                    #if DEBUG
                    print("An error has occurred.")
                    #endif
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                let result = JSON(data)["statusCode"].intValue
                
                if result != 200 {
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                completion( JSON(data) )
                break
            case .failure(let error):
                
                #if DEBUG
                print(error)
                #endif
                
                completion(JSON(["result":false, "statusCode":error.responseCode, "code":CommonRequest.API_MSG_10001, "message":"service_error".localized()]))
            }
            
        }
    }
    
    
    /**
     - Note: DELETE with Body
     */
    public func requestDELETEwithBody(_ path:String, params:[String : Any], completion: @escaping (_ result: JSON) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(JSON(["result":false, "code":CommonRequest.NET_MSG_00000]))
            return
        }
        
        let headers:HTTPHeaders = ["Accept-Charset": "charset=UTF-8"]
        
        /** 한글 URL 처리 */
        let encodedString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        
        AF.request(url.absoluteString, method: .delete, parameters: params, encoding: JSONEncoding(options: []), headers: headers).responseJSON { response in
            
            /** AFDataResponse<Any> */
            
            #if DEBUG
            debugPrint(response)
            #endif

            switch response.result {
            case .success(let data):
                
                if String(describing: data).contains("error") {
                    
                    #if DEBUG
                    print("An error has occurred.")
                    #endif
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                let result = JSON(data)["statusCode"].intValue
                
                if result != 200 {
                    
                    var message = JSON(data)["message"].stringValue
                    if "" == message {
                        message = "service_error".localized()
                    }
                    
                    completion(JSON(["result":false, "code":CommonRequest.API_MSG_10001, "message":message]))
                    break
                }
                
                completion( JSON(data) )
                break
            case .failure(let error):
                
                #if DEBUG
                print(error)
                #endif
                
                completion(JSON(["result":false, "statusCode":error.responseCode, "code":CommonRequest.API_MSG_10001, "message":"service_error".localized()]))
            }
            
        }
    }
}
