import Foundation


/**
 - Note: 유효성 검사 유틸리티
 */
class ValidateUtils {
    
    private static var sharedValidateUtils: ValidateUtils = {
        
        let obj = ValidateUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> ValidateUtils {
        return sharedValidateUtils
    }
    
    /** 이메일 유효성 검사 */
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
}
