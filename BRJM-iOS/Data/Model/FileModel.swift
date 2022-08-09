import Foundation
import UIKit


/**
 - Note:
 */
public class FileModel: NSObject {
    
    var closure: (() -> Void)?
    
    public var fileName: String = ""
    public var file: UIImage?
    public var url: URL!
}
