import UIKit
import ObjectiveC


var associationKeyMaxLength: Int = 0

@IBDesignable
extension UITextField {
    
     @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &associationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &associationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)

        selectedTextRange = selection
    }
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true

        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    /**
     - note: clearButton 이미지 변경
     */
    func clearButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.clear(sender:)), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc func clear(sender: AnyObject) {
        self.text = ""
    }
    
    /**
     - note: 폰트 적용
     */
    func setFont() {
        self.textColor = .black
        self.font = UIFont.leferiBase(.bold, size: 18)
    }
    
    func setFont(_ type: UIFont.LeferiBaseType) {
        self.textColor = .black
        self.font = UIFont.leferiBase(type, size: 18)
    }
    
    func setPlaceholder(text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : BaseConstraint.COLOR_GRAY_30])
    }
    
    func setPlaceholder(_ type: UIFont.LeferiBaseType, text: String) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : BaseConstraint.COLOR_GRAY_30, NSAttributedString.Key.font : UIFont.leferiBase(type, size: 18)])
    }
}

class UITextFieldPadding : UITextField {

  let padding = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 10)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
    
}
