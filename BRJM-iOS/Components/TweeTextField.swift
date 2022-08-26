import UIKit
import TweeTextField


/**
 - Note: 삭제 버튼, 라인 포함 텍스트 필드
 */
class TweeTextField: TweeActiveTextField {
    
    public var btnDelete = UIButton()
    
    public var deleteTapped = {}
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    /** initialize */
    func initialize() {
     
        /** 폰트 설정 */
        setFont()
        
        /** 틴트 컬러 설정 */
        TweeTextField.appearance().tintColor = BaseConstraint.COLOR_PRIMARY
        
        /** 플레이스 홀더 컬러 설정 */
        placeholderColor = BaseConstraint.COLOR_LIGHT_GRAY
        
        /** 라인 설정 */
        lineColor = BaseConstraint.COLOR_LIGHT_GRAY
        lineWidth = 1.0
        activeLineColor = BaseConstraint.COLOR_LIGHT_GRAY
        activeLineWidth = 1.0
        
        /** 라인 애니메이션 동작 시간 */
        animationDuration = 0.2
        
        
        /// -----------------------------------------------------
        /** 버튼 설정 */
        self.btnDelete.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        
        self.addSubview(btnDelete)
        btnDelete.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btnDelete.topAnchor.constraint(equalTo: self.topAnchor),
            btnDelete.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            btnDelete.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            btnDelete.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        btnDelete.setImage(UIImage(named: "icDeleteTextField"))
        btnDelete.isHidden = true
        
        self.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func deleteTapped(_ sender: UIButton) {
        
        btnDelete.isHidden = true
        self.text = ""
        self.deleteTapped()
    }
    
    @objc func textEditingChanged(_ sender: TweeTextField) {
        
        btnDelete.isHidden = "" == sender.text ?? ""
        self.bringSubviewToFront(self.btnDelete)
    }
    
    public func setButtonImage(_ image: UIImage?) {
        
        btnDelete.setImage(image)
    }
}
