import Foundation


/**
 - Note: VersionModel
 */
public class VersionModel: BaseModel {
    
    // var closure: (() -> Void)?
    
    /** 버전 정보 */
    public var appVer:String = ""
    public var appDesc:String = ""
    public var osType:String = ""
    
    /** 점검 정보 */
    public var emergency:Bool = false
    public var emergencyMessage:String = ""
    public var emergencyLink:String = ""
}
