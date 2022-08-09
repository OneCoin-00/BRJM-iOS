import UIKit

final class BottomPopupPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private unowned var attributesOwner: BottomPresentableViewController
    
    init(attributesOwner: BottomPresentableViewController) {
        self.attributesOwner = attributesOwner
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return attributesOwner.popupPresentDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toVC = transitionContext.viewController(forKey: .to)!
        transitionContext.containerView.addSubview(toVC.view)
        let presentFrame = transitionContext.finalFrame(for: toVC)
        let initialFrame = CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.size.height), size: presentFrame.size)
        toVC.view.frame = initialFrame
        
        /*
        UIView.animate(withDuration: transitionDuration(using: transitionContext), options: .curveEaseOut, animations: {
            toVC.view.frame = presentFrame
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        */
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveEaseOut, animations: {
            toVC.view.frame = presentFrame
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
