import UIKit


extension UIImage {
    // 이미지 사이즈 조절
    func resizeImage(width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // 이미지 사이즈 조절
     func resizeImage(width : Float, height : Float) -> UIImage? {
         let cgWidth = CGFloat(width)
         let cgHeight = CGFloat(height)
         
         // Begine Context
         UIGraphicsBeginImageContext(CGSize(width: cgWidth, height: cgHeight))
         // Get Current Context
         let context = UIGraphicsGetCurrentContext()
         context?.translateBy(x : 0.0, y : cgHeight)
         context?.scaleBy(x: 1.0, y: -1.0)
         context?.draw(self.cgImage!, in: CGRect(x: 0.0, y: 0.0, width: cgWidth, height: cgHeight))
         let scaledImage : UIImage? = UIGraphicsGetImageFromCurrentImageContext()
         // End Context
         UIGraphicsEndImageContext()
         
         if (scaledImage != nil) {
             return scaledImage
         }
         else {
             return nil
         }
     }
}
