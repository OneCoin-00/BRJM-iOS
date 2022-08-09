import UIKit
import ObjectiveC


var disabledColorHandle: UInt8 = 0
var highlightedColorHandle: UInt8 = 0
var selectedColorHandle: UInt8 = 0

@IBDesignable
extension UIButton {
    
    /*
    open override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width + titleEdgeInsets.left + titleEdgeInsets.right, height: labelSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom)
        
        return desiredButtonSize
    }
    */
    
    /**
     SparrowKit: Set title for all states.
     
     - parameter title: Title for button.
     */
    func setTitle(_ title: String, color: UIColor) {
        if let attributedTitle = attributedTitle(for: .normal) {
            let attributes: [NSAttributedString.Key: Any] = [.font: titleLabel?.font, .foregroundColor: color]
            let attributedText = NSAttributedString(string: title, attributes: attributes)
            self.setAttributedTitle(attributedText, for: .normal)
        }else{
            setTitle(title, for: .normal)
            setTitleColor(color)
        }
    }
    
    func setTitle(_ title: String) {
        if let attributedTitle = attributedTitle(for: .normal) {
            let attributes: [NSAttributedString.Key: Any] = [.font: titleLabel?.font, .foregroundColor: titleLabel?.textColor]
            let attributedText = NSAttributedString(string: title, attributes: attributes)
            self.setAttributedTitle(attributedText, for: .normal)
        }else{
            setTitle(title, for: .normal)
        }
    }
    
    func setTitle(_ title: String, color: UIColor, font: UIFont) {
        
        if let attributedTitle = attributedTitle(for: .normal) {
            let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
            let attributedText = NSAttributedString(string: title, attributes: attributes)
            self.setAttributedTitle(attributedText, for: .normal)
        }else{
            setTitle(title, for: .normal)
            setTitleColor(color)
        }
    }
    
    /**
     SparrowKit: Set title color for all states.
     Also adding higlight color automatically for clear press event.
     
     - parameter color: Color of title.
     */
    func setTitleColor(_ color: UIColor) {
        setTitleColor(color, for: .normal)
        setTitleColor(color.withAlphaComponent(0.7), for: .highlighted)
    }
    
    /**
     SparrowKit: Set image for all states.
     
     - parameter image: Image for button.
     */
    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        setImage(image, for: .disabled)
    }
    
    /**
     SparrowKit: Remove all targets.
     */
    func removeAllTargets() {
        self.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: state)
    }
    
    func roundCorners(corners: UIRectCorner, radius: Int = 8) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
        clipsToBounds = true
    }
    
    func setAnimateBackgroundColor(color: UIColor, duration:Float) {
        
        UIView.animate(withDuration: TimeInterval(duration)) {
            self.layer.backgroundColor = color.cgColor
        }
    }
    
    @IBInspectable
    var disabledColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &disabledColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(color, for: .disabled)
                objc_setAssociatedObject(self, &disabledColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .disabled)
                objc_setAssociatedObject(self, &disabledColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    @IBInspectable
    var highlightedColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &highlightedColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(color, for: .highlighted)
                objc_setAssociatedObject(self, &highlightedColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .highlighted)
                objc_setAssociatedObject(self, &highlightedColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    @IBInspectable
    var selectedColor: UIColor? {
        get {
            if let color = objc_getAssociatedObject(self, &selectedColorHandle) as? UIColor {
                return color
            }
            return nil
        }
        set {
            if let color = newValue {
                self.setBackgroundColor(color, for: .selected)
                objc_setAssociatedObject(self, &selectedColorHandle, color, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            } else {
                self.setBackgroundImage(nil, for: .selected)
                objc_setAssociatedObject(self, &selectedColorHandle, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
