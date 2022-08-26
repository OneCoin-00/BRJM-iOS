import UIKit


/**
 - Note: 삭제 버튼 포함 텍스트 필드
 */
class TextFieldWithDelete: UITextField {
    
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
        TextFieldWithDelete.appearance().tintColor = BaseConstraint.COLOR_PRIMARY
        
        
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
    
    @objc func textEditingChanged(_ sender: TextFieldWithDelete) {
        
        btnDelete.isHidden = "" == sender.text ?? ""
        self.bringSubviewToFront(self.btnDelete)
    }
    
    public func setButtonImage(_ image: UIImage?) {
        
        btnDelete.setImage(image)
    }
    
    public func setText(_ text: String) {
        
        self.text = text
        btnDelete.isHidden = "" == text
    }
}

