import UIKit
import QuartzCore
import Lottie


/**
 - 로딩 인디케이터
 */
public struct SLoader {
    
    public static var showFadeOutAnimation = false
    public static var viewBackgroundDark: Bool = false
    public static var loadOverApplicationWindow: Bool = false
    
    public static let animationView = AnimationView()
    public static var instance: LoadingResource?
    public static var backgroundView: UIView!
    fileprivate static var hidingInProgress = false
    
    
    public static func showLoading(_ disableUI: Bool) {
        SLoader().startLoadingActivity(disableUI)
    }
    
    public static func show() {
        
        // if instance != nil { instance?.clearView() }
        SLoader().startLoadingActivity(true)
    }
    
    public static func hide() {
        DispatchQueue.main.async {
            instance?.hideActivity()
        }
    }
    
    public static func hideDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            instance?.hideActivity()
        }
    }
    
    public class LoadingResource: UIView {
        
        fileprivate var disableUIIntraction = false
        
        convenience init(disableUI: Bool) {
            self.init(frame: CGRect(x: 0,
                                    y: 0,
                                    width: 300,
                                    height: 300))
            center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
            autoresizingMask = [.flexibleTopMargin,
                                .flexibleLeftMargin,
                                .flexibleBottomMargin,
                                .flexibleRightMargin]
            alpha = 1
            
            
            
            

            let animation = Animation.named("loading") //.named("loading", subdirectory: "Lottie")
            
            animationView.animation = animation
            animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
            animationView.contentMode = .scaleAspectFit
            animationView.play()
            animationView.loopMode = .loop
            
            DispatchQueue.main.async {
                
                self.addSubview(animationView)
            }
            
            guard disableUI else {
                return
            }
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            disableUIIntraction = true
        }
        
        fileprivate func showLoadingActivity() {
            
            guard loadOverApplicationWindow else {
                topMostViewController!.view.addSubview(self)
                return
            }
            UIApplication.shared.windows.first?.addSubview(self)
        }
        
        fileprivate func hideActivity() {
            
            clearView()
        }
        
        fileprivate func clearView() {
            
            animationView.pause()
            removeAllSubViews()
            removeFromSuperview()
            
            instance = nil
            hidingInProgress = false
            
            if backgroundView != nil {
                UIView.animate(withDuration: 0.1, animations: {
                    backgroundView.backgroundColor = backgroundView.backgroundColor?.withAlphaComponent(0)
                }, completion: { _ in
                    backgroundView.removeFromSuperview()
                })
            }
            
            guard disableUIIntraction else {
                return
            }
            disableUIIntraction = false
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

private extension SLoader {
    
    private func startLoadingActivity(_ disableUI: Bool) {
        
        // DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {}
        DispatchQueue.main.async {
            
            guard SLoader.instance == nil else {
                return
            }
           
            guard topMostViewController != nil else {
                return
            }
           
            SLoader.instance = LoadingResource(disableUI: disableUI)
            DispatchQueue.main.async {
                if SLoader.viewBackgroundDark {
                    if SLoader.backgroundView == nil {
                        SLoader.backgroundView = UIView(frame: UIApplication.shared.keyWindow!.frame)
                    }
                    SLoader.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0)
                    topMostViewController?.view.addSubview(SLoader.backgroundView)
                    UIView.animate(withDuration: 0.2, animations: {SLoader.backgroundView.backgroundColor = SLoader.backgroundView.backgroundColor?.withAlphaComponent(0.5)})
                }
                SLoader.instance?.showLoadingActivity()
           }
        }
    }
}

private extension UIScreen {
    
    class var screenWidth: CGFloat {
        get {
            if UIInterfaceOrientation.portrait.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
        }
    }
    
    class var screenHeight: CGFloat {
        get {
            if UIInterfaceOrientation.portrait.isPortrait {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
        }
    }
}

private var topMostViewController: UIViewController? {
    var presentedVC = UIApplication.shared.keyWindow?.rootViewController
    while let controller = presentedVC?.presentedViewController {
        presentedVC = controller
    }
    return presentedVC
}
