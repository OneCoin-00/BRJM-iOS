import Foundation
import UIKit
import Nuke


extension UITableViewCell {

    /**
     - note: 이미지 로드
     */
    public func setNukeImage(url: String, callback:@escaping (UIImage?) -> ()) {
        
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        if let url = URL(string: encodedString) {
         
            // let request = ImageRequest(url: url, processors: [ImageProcessors.Resize(size: iv.bounds.size)])
            let request = ImageRequest(url: url)
            
            Nuke.ImagePipeline.shared.loadImage(with: request) { result in
                
                if case let .success(response) = result {
                    callback(response.container.image)
                }
            }
        }
    }

    public func setNukeImage(url: String, iv: UIImageView, placeholderImageName: String = "", callback:@escaping (UIImage?) -> ()) {

        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string: encodedString) {
            
            // let request = ImageRequest(url: url, processors: [ImageProcessors.Resize(size: iv.bounds.size)])
            let request = ImageRequest(url: url)
            var options: ImageLoadingOptions = ImageUtils.shared().getOptions()
            
            if "" != placeholderImageName {
                options.placeholder = UIImage(named: placeholderImageName)
            }
            
            // Nuke.loadImage(with: request, options: options, into: iv)
            Nuke.loadImage(with: request, options: options, into: iv) { result in
             
                if case let .success(response) = result {
                    callback(response.container.image)
                }
            }
        }else {
            
        }
    }

    public func setNukeImage(url: String, iv: UIImageView, placeholderImageName: String = "", errorCallback:@escaping () -> (), callback:@escaping (UIImage?) -> ()) {

        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string: encodedString) {
            
            // let request = ImageRequest(url: url, processors: [ImageProcessors.Resize(size: iv.bounds.size)])
            let request = ImageRequest(url: url)
            var options: ImageLoadingOptions = ImageUtils.shared().getOptions()
            
            if "" != placeholderImageName {
                options.placeholder = UIImage(named: placeholderImageName)
            }
            
            // Nuke.loadImage(with: request, options: options, into: iv)
            Nuke.loadImage(with: request, options: options, into: iv) { result in
             
                if case let .success(response) = result {
                    callback(response.container.image)
                } else {
                    errorCallback()
                }
            }
        }else {
            errorCallback()
        }
    }

}
