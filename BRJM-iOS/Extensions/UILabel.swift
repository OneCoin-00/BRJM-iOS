import UIKit
 

extension UILabel {
    
    func setLineSpacing(lineSpacing: Double, kern: Double = 0) {
        
        let lineSpacing = lineSpacing - Double(self.font.lineHeight)
        
        let textAlign = self.textAlignment
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = CGFloat(lineSpacing)
        let attributes = [NSAttributedString.Key.paragraphStyle : style, .kern: kern] as [NSAttributedString.Key : Any]
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: attributes)
        self.textAlignment = textAlign
    }
    
    func kernedSpacedText(_ text: String,
                                    letterSpacing: CGFloat = 0.0,
                                    lineHeight: CGFloat? = nil) -> NSMutableAttributedString {
        // TODO add the font attribute

        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: letterSpacing,
                                      range: NSRange(location: 0, length: text.utf16.count))

        if let lineHeight = lineHeight {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineHeight

            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSRange(location: 0, length: text.utf16.count))
        }

        return attributedString
    }
    
    func boundingRect(range: NSRange) -> CGRect? {

        guard let attributedText = attributedText else { return nil }

        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()

        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer(size: intrinsicContentSize)

        textContainer.lineFragmentPadding = 0.0

        layoutManager.addTextContainer(textContainer)

        var glyphRange = NSRange()

        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)

        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
    
    var allFonts: [UIFont] {
        return UILabel.allFontNames.compactMap { UIFont(name: $0, size: font.pointSize) }
    }

    static let allFontNames: [String] = {
        var fontNames = [String]()
        UIFont.familyNames.sorted().forEach { familyName in
            UIFont.fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                fontNames.append(fontName)
            }
        }
        return fontNames
    }()
    
    func setHighlightTextColor(defColor: UIColor, highlightText: [String], highlightTextColor: UIColor, _font:UIFont?=nil){
        // NSMutableAttributedString Type으로 바꾼 text를 저장
        let attributedStr = NSMutableAttributedString(string: text!)

        // text의 range 중에서 "Bonus"라는 글자는 UIColor를 blue로 변경
        highlightText.forEach{
            attributedStr.addAttribute(.foregroundColor, value: highlightTextColor, range: (text! as NSString).range(of: $0))
            if(_font != nil){
                attributedStr.addAttribute(.font, value: _font, range: (text! as NSString).range(of: $0))
            }
        }
        
        // 설정이 적용된 text를 label의 attributedText에 저장
        attributedText = attributedStr

    }
    
    /** HTML 변환 */
    func setAttributedHtmlText(_ html: String) {
        if let attributedText = html.attributedHtmlString {
            self.attributedText = attributedText
        }
    }
    
    /** HTML (폰트 적용) 변환 */
    func setHTMLFromString(_ html: String) {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(self.font!.pointSize)\">%@</span>", html)

        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)

        self.attributedText = attrStr
    }
    
    
    /// ------------------------------------------------------------
    /// Typography
    /** 파라미터 값 추후 변경 */
    /**
     - note: 대제목
     - parameters:
        - type: 폰트 굵기 - bord or medium
     */
    func headline(type: UIFont.LeferiBaseType) {
        self.font = UIFont.leferiBase(type, size: 24)
        self.setLineSpacing(lineSpacing: 34)
    }
    
    /**
     - note: 소제목
     - parameters:
     */
    func subheading(type: UIFont.LeferiBaseType, size: CGFloat = UIFont.systemFontSize) {
        self.font = UIFont.leferiBase(type, size: size)
        self.setLineSpacing(lineSpacing: 30)
    }
    
    /**
     - note: 본문  제목
     - parameters:
        - type: 폰트 굵기
        - size: 폰트 크기 - 17 or 16
     */
    func bodyText(type: UIFont.LeferiBaseType, size: CGFloat = UIFont.systemFontSize) {
        self.font = UIFont.leferiBase(type, size: size)
        self.setLineSpacing(lineSpacing: 24)
    }
    
    /**
     - note: 본문  내용
     - parameters:
        - type: 폰트 굵기 - semibord or reqular
     */
    func bodyText(type: UIFont.LeferiBaseType) {
        self.font = UIFont.leferiBase(type, size: 15)
        self.setLineSpacing(lineSpacing: 24)
    }
    
    /**
     - note: 알림 및 작은 텍스트
     - parameters:
        - type: 폰트 굵기 - semibord or reqular
        - size: 폰트 크기 - 14 or 12
        - lineSpacing: 폰트 행간 - 22 or 16
     */
    func smallLetters(type: UIFont.LeferiBaseType, size: CGFloat = UIFont.systemFontSize, lineSpacing: Double) {
        self.font = UIFont.leferiBase(type, size: size)
        self.setLineSpacing(lineSpacing: lineSpacing)
    }
}
