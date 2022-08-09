import Foundation
import UIKit
import Accelerate.vImage
import Nuke


class ImageUtils {
    
    private static var sharedImageUtils: ImageUtils = {
        
        let obj = ImageUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> ImageUtils {
        return sharedImageUtils
    }
 
    
    // # Nuke
    private var pipeline = ImagePipeline.shared
    
    func getOptions() -> ImageLoadingOptions {
        
        var options = ImageLoadingOptions(
            placeholder: UIImage(named: "placeholder"),
            transition: .fadeIn(duration: BaseConstraint.IMAGE_FADEIN_DURATION),
            failureImage: UIImage(named: "failureImage"),
            contentModes: .init(success: .scaleAspectFill, failure: .center, placeholder: .scaleAspectFill)
        )
        options.pipeline = getPipeline()
        
        _ = ImagePrefetcher(destination: .diskCache)
        
        return options
    }
    
    func getOptionsWithFit() -> ImageLoadingOptions {
        
        var options = ImageLoadingOptions(
            placeholder: UIImage(named: "icMemberImage"),
            transition: .fadeIn(duration: BaseConstraint.IMAGE_FADEIN_DURATION),
            failureImage: UIImage(named: "icMemberImage"),
            contentModes: .init(success: .scaleAspectFit, failure: .center, placeholder: .scaleAspectFit)
        )
        options.pipeline = getPipeline()
        
        _ = ImagePrefetcher(destination: .diskCache)
        
        return options
    }
    
    func getPipeline() -> ImagePipeline {
        
        pipeline = ImagePipeline {
            $0.dataLoader = DataLoader(configuration: {
                let conf = DataLoader.defaultConfiguration
                conf.urlCache = DataLoader.sharedUrlCache
                return conf
            }())

            $0.isDecompressionEnabled = true
            $0.isTaskCoalescingEnabled = true
            $0.isResumableDataEnabled = true
            $0.isRateLimiterEnabled = true
            $0.isStoringPreviewsInMemoryCache = true
            $0.imageCache = ImageCache.shared
            $0.dataCache = try! DataCache(name: "com.hiconsy.app.jj.DataCache")
        }
        
        return pipeline
    }
    
    
    
    // #
    func resizedImage(at url: URL, for size: CGSize) -> UIImage? {
        // Decode the source image
        guard let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil),
            let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [CFString: Any],
            let imageWidth = properties[kCGImagePropertyPixelWidth] as? vImagePixelCount,
            let imageHeight = properties[kCGImagePropertyPixelHeight] as? vImagePixelCount
        else {
            return nil
        }

        // Define the image format
        var format = vImage_CGImageFormat(bitsPerComponent: 8,
                                          bitsPerPixel: 32,
                                          colorSpace: nil,
                                          bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                                          version: 0,
                                          decode: nil,
                                          renderingIntent: .defaultIntent)

        var error: vImage_Error

        // Create and initialize the source buffer
        var sourceBuffer = vImage_Buffer()
        defer { sourceBuffer.data.deallocate() }
        error = vImageBuffer_InitWithCGImage(&sourceBuffer,
                                             &format,
                                             nil,
                                             image,
                                             vImage_Flags(kvImageNoFlags))
        guard error == kvImageNoError else { return nil }

        // Create and initialize the destination buffer
        var destinationBuffer = vImage_Buffer()
        error = vImageBuffer_Init(&destinationBuffer,
                                  vImagePixelCount(size.height),
                                  vImagePixelCount(size.width),
                                  format.bitsPerPixel,
                                  vImage_Flags(kvImageNoFlags))
        guard error == kvImageNoError else { return nil }

        // Scale the image
        error = vImageScale_ARGB8888(&sourceBuffer,
                                     &destinationBuffer,
                                     nil,
                                     vImage_Flags(kvImageHighQualityResampling))
        guard error == kvImageNoError else { return nil }

        // Create a CGImage from the destination buffer
        guard let resizedImage =
            vImageCreateCGImageFromBuffer(&destinationBuffer,
                                          &format,
                                          nil,
                                          nil,
                                          vImage_Flags(kvImageNoAllocate),
                                          &error)?.takeRetainedValue(),
            error == kvImageNoError
        else {
            return nil
        }

        return UIImage(cgImage: resizedImage)
    }
    
    
    // # 이벤트 성공 스티커(eventSuccessSticker1 ~ eventSuccessSticker6)
    public func randomSuccessSticker() -> String {
        
        return "eventSuccessSticker\(Int.random(in: 1...6))"
    }
    
    /**
     - Note: 이미지 마스크
     */
    public func maskImage(image: UIImage, withMask maskImage: UIImage) -> UIImage {

        let maskRef = maskImage.cgImage

        let mask = CGImage(
            maskWidth: maskRef!.width,
            height: maskRef!.height,
            bitsPerComponent: maskRef!.bitsPerComponent,
            bitsPerPixel: maskRef!.bitsPerPixel,
            bytesPerRow: maskRef!.bytesPerRow,
            provider: maskRef!.dataProvider!,
            decode: nil,
            shouldInterpolate: true)

        let masked = image.cgImage!.masking(mask!)
        let maskedImage = UIImage(cgImage: masked!)
        
        return maskedImage
    }
    
    /**
     - Note: 이미지 앱에 저장
     */
    func saveImage(image: UIImage, name: String, onSuccess: @escaping ((Bool) -> Void)) {
        
        guard let data: Data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }
        
        if let directory: NSURL =
            try? FileManager.default.url(for: .documentDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: false) as NSURL {
            do {
                try data.write(to: directory.appendingPathComponent(name)!)
                onSuccess(true)
            } catch let error as NSError {
                CommonUtils.log("Could not saveImage: \(error), \(error.userInfo)")
                onSuccess(false)
            }
        }
    }
}
