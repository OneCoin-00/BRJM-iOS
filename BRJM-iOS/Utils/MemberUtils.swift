import Foundation
import UIKit
import AVFoundation
import AVKit
import AudioToolbox
import DeviceKit
import SwiftyUserDefaults


/**
 - Note: 회원 정보 관리 유틸리티
 */
class MemberUtils {
    
    private static var _shared: MemberUtils = {
        
        let obj = MemberUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> MemberUtils {
        return _shared
    }
    
}
