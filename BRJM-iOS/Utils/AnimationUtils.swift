import Foundation
import UIKit
import AVFoundation


class AnimationUtils {
    
    private static var _share: AnimationUtils = {
        
        let obj = AnimationUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> AnimationUtils {
        return _share
    }
    
    
    
    //--------------------------------------------------
    // 다이얼로그 팝업 위 애니메이션
    public func moveUpWithDialog(view:UIView) {
        
        view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: view.height)
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.15
            settings.ease = .easeOutQuint
            return {
                view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(0))
            }
        }).callback {
        }
    }
    
    public func moveUpWithDialog(view:UIView, callback:@escaping ()->()) {
        
        view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: view.height)
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.15
            settings.ease = .easeOutQuint
            return {
                view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(0))
            }
        }).callback {
            callback()
        }
    }
    
    public func moveDownWithDialog(view:UIView) {
        
        view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(0))
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.0
            settings.ease = .easeOutQuint
            return {
                view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: view.height)
            }
        }).callback {
        }
    }
    
    public func moveDownWithDialog(view:UIView, callback:@escaping ()->()) {
        
        view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(0))
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.0
            settings.ease = .easeOutQuint
            return {
                view.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: view.height)
            }
        }).callback {
            callback()
        }
    }
    
    public func dissolve(view:UIView, from: CGFloat, to: CGFloat) {
        
        view.alpha = from
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.0
            settings.ease = .easeOutQuint
            return {
                view.alpha = to
            }
        }).callback {
        }
    }
    
    public func dissolve(view:UIView, to: CGFloat) {
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = 0.0
            settings.ease = .easeOutQuint
            return {
                view.alpha = to
            }
        }).callback {
        }
    }
    
    public func dissolve(view:UIView, delay: Double, to: CGFloat) {
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.25
            settings.delay = TimeInterval(delay)
            settings.ease = .easeOutQuint
            return {
                view.alpha = to
            }
        }).callback {
        }
    }
    
    public func dissolve(view:UIView, to: CGFloat, duration: TimeInterval) {
        
        anim({ (settings) -> (animClosure) in
            settings.duration = duration
            settings.delay = 0.0
            settings.ease = .easeOutQuint
            return {
                view.alpha = to
            }
        }).callback {
        }
    }
}
