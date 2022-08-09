import UIKit


var cornerRadiusValue : CGFloat = 0
var corners : UIRectCorner = []

@IBDesignable
extension UIView {
    
    public var height: CGFloat {
        get
        {
            return self.frame.size.height
        }
    }

    public var width: CGFloat {
        get
        {
            return self.frame.size.width
        }
    }
    
    func setCorner(newValue: Bool, for corner: UIRectCorner) {
        if newValue {
            addRectCorner(corner: corner)
        } else {
            removeRectCorner(corner: corner)
        }
    }

    func addRectCorner(corner: UIRectCorner) {
        corners.insert(corner)
        updateCorners()
    }

    func removeRectCorner(corner: UIRectCorner) {
        if corners.contains(corner) {
            corners.remove(corner)
            updateCorners()
        }
    }

    func updateCorners() {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadiusValue, height: cornerRadiusValue))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func loadView(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    var mainView: UIView? {
        return subviews.first
    }
    
    func constraintWith(identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first(where: {$0.identifier == identifier})
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.clipsToBounds = true
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)) {
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)) {
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)) {
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)) {
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    public func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview()})
    }
}
