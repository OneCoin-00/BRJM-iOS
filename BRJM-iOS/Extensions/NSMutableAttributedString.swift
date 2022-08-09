import UIKit


extension NSMutableAttributedString {

    func highlightTarget(target: String, color: UIColor) -> NSMutableAttributedString {
        
        addAttribute(.foregroundColor, value: color, range: (self.string as NSString).range(of: target))
        return self
    }
    
    func kernTarget(target: String, kern:Float) -> NSMutableAttributedString {
        addAttribute(.kern, value: kern, range: (self.string as NSString).range(of: target))
        return self
    }
    
    func boldTarget(target: String, font:UIFont, color: UIColor) -> NSMutableAttributedString {
        
        addAttribute(.foregroundColor, value: color, range: (self.string as NSString).range(of: target))
        addAttribute(.font, value: font, range: (self.string as NSString).range(of: target))
        return self
    }
}

