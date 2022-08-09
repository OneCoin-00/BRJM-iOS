import Foundation
import UIKit
import AVFoundation
import AVKit
import AudioToolbox
import DeviceKit


/**
 - Note: 공통 유틸리티
 */
class CommonUtils {
    
    private static var _shared: CommonUtils = {
        
        let obj = CommonUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> CommonUtils {
        return _shared
    }
    
    
    class func getVersion() -> String {
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "no version info"
        }
        return version
    }
    
    class func getOSVersion() -> String {
        let os = ProcessInfo().operatingSystemVersion
        return String(os.majorVersion) + "." + String(os.minorVersion) + "." + String(os.patchVersion)
    }
    
    class func deviceName() -> String {

        var systemInfo = utsname()
        uname(&systemInfo)

        guard let iOSDeviceModelsPath = Bundle.main.path(forResource: "iOSDeviceModelMapping", ofType: "plist") else { return "" }
        guard let iOSDevices = NSDictionary(contentsOfFile: iOSDeviceModelsPath) else { return "" }

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return iOSDevices.value(forKey: identifier) as! String
    }
    
    class func log(_ items:Any ...) -> Void {
        
        if items.count == 0 { return }
        if items.description == "" { return }
        
        print(items)
    }
    
    // #
    public var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public var screenWidth: CGFloat {
        #if os(iOS)
            if screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.width
        #endif
    }
    
    public var screenHeight: CGFloat {
        #if os(iOS)
            if screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.height
        #endif
    }
}
