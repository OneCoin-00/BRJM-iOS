import Foundation
import SwiftyJSON
import Alamofire


/**
 - Note: 파일 업로드 서비스
 */
enum APIError: Error {
    case data
    case decodingJSON
}

struct MultipartsUploadService {
    
    static let shared = MultipartsUploadService()
    
    func postData(url: String,
                  method: HTTPMethod = .post,
                  withName: String = "prof",
                  parameters: [String: Any],
                  imageData: [FileModel],
                  completion: @escaping (_ result: Result<BaseModel, APIError>) -> Void) {
        
        #if DEBUG
        if imageData == [] {
            print( "[Request] \(method.rawValue) \(url)" )
            print( "[Request] \(parameters)" )
        }
        #endif
        
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data" ]
        
        
        AF.upload(multipartFormData: { (multipart) in
            
            for dao in imageData {
                if let image = dao.file?.jpegData(compressionQuality: 0.7) {
                    multipart.append(image, withName: withName, fileName: "\(dao.fileName)", mimeType: "image/jpeg")
                }
            }
            
            for (key, value) in parameters {
                
                // e.g 배열 추가
                /*
                if ((key == "category") || (key == "friendIdx")) {
                    
                    for idx in value as! [String] {
                        multipart.append("\(idx)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                    }
                }
                */
                multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
            }
        }, to: url
        , method: method
        , headers: header).response { response in
            
            let json = JSON(response.data as Any)
            
            #if DEBUG
            if imageData == [] {
                print( "[Response] \(json)" )
            }
            #endif
            
            let result = json["result"].boolValue
            
            if result {
                
                let dao: BaseModel = BaseModel()
                dao.result = result
                dao.message = json["message"].stringValue
                completion(.success(dao))
            } else {
                
                completion(.failure(APIError.data))
            }
        }
    }
}
