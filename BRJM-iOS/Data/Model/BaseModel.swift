import Foundation


/**
 - Note: BaseModel
 */
public class BaseModel: NSObject {
    
    var closure: (() -> Void)?
    
    public var statusCode:Int = 200 /** HTTP 응답 코드 */
    public var code:String = ""/** API 응답 코드 */
    public var message:String = ""/** API 응답 메세지 */
    public var result:Bool = false/** API 응답 성공 여부 */
}
