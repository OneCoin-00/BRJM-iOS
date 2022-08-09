import Foundation
import UIKit


/**
 - Note: 폰트 확장
 */
extension UIFont {
    
    /*
     LeferiBase-regular
     LeferiBase-Bold
     LeferiPointWhite
     LeferiPointWhite-Oblique
     LeferiPointBlack
     LeferiPointBlack-Oblique
     LeferiPointSpecial
     LeferiPointSpecial-Italic
    */
    
    /** LeferiBase */
    public enum LeferiBaseType: String {
        case bold = "Bold"
        case regular = "Regular"
    }
    
    /** LeferiPoint */
    public enum LeferiPointType: String {
        case white = "White"
        case whiteOblique = "WhiteOblique"
        case black = "Black"
        case blackOblique = "BlackOblique"
        case special = "Special"
        case specialItalic = "SpecialItalic"
    }
    
    
    static func leferiBase(_ type: LeferiBaseType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "LeferiBase\(type.rawValue)", size: size)!
    }
    
    static func leferiPoint(_ type: LeferiPointType = .white, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "LeferiPoint\(type.rawValue)", size: size)!
    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

    
    static func printAll() {
        familyNames.sorted().forEach { familyName in
            print("*** \(familyName) ***")
            fontNames(forFamilyName: familyName).sorted().forEach { fontName in
                print("\(fontName)")
            }
        }
    }
}
