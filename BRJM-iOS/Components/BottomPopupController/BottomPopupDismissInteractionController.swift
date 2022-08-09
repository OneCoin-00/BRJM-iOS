import UIKit

protocol BottomPopupDismissInteractionControllerDelegate: class {
    func dismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat)
}

final class BottomPopupDismissInteractionController: UIPercentDrivenInteractiveTransition {
    private let kMinPercentOfVisiblePartToCompleteAnimation = CGFloat(0.5)
    private let kSwipeDownThreshold = CGFloat(1000)
    private weak var presentedViewController: BottomPresentableViewController?
    private weak var transitioningDelegate: BottomPopupTransitionHandler?
    private unowned var attributesDelegate: BottomPopupAttributesDelegate
    weak var delegate: BottomPopupDismissInteractionControllerDelegate?
    
    private var currentPercent: CGFloat = 0 {
        didSet {
            delegate?.dismissInteractionPercentChanged(from: oldValue, to: currentPercent)
        }
    }
    
    init(presentedViewController: BottomPresentableViewController?, attributesDelegate: BottomPopupAttributesDelegate) {
        self.presentedViewController = presentedViewController
        self.transitioningDelegate = presentedViewController?.transitioningDelegate as? BottomPopupTransitionHandler
        self.attributesDelegate = attributesDelegate
        super.init()
        preparePanGesture(in: presentedViewController?.view)
    }
    
    private func finishAnimation(withVelocity velocity: CGPoint) {
        if currentPercent > kMinPercentOfVisiblePartToCompleteAnimation || velocity.y > kSwipeDownThreshold {
            finish()
        } else {
            cancel()
        }
    }
    
    public func preparePanGesture(in view: UIView?) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        presentedViewController?.view?.addGestureRecognizer(panGesture)
    }
    
    @objc public func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        guard attributesDelegate.popupShouldBeganDismiss else { return }
        if !presentedViewController!.popupShouldDismissInteractivelty { return }
        
        let translationY = pan.translation(in: presentedViewController?.view).y
        currentPercent = min(max(translationY/(presentedViewController?.view.frame.size.height ?? 0), 0), 1)
        
        switch pan.state {
        case .began:
            transitioningDelegate?.isInteractiveDismissStarted = true
            presentedViewController?.dismiss(animated: true, completion: nil)
        case .changed:
            
            /*
            if let t = transitioningDelegate {
                t.isInteractiveDismissStarted = true
                presentedViewController?.dismiss(animated: true, completion: nil)
            }
            */
            
            update(currentPercent)
        default:
            let velocity = pan.velocity(in: presentedViewController?.view)
            transitioningDelegate?.isInteractiveDismissStarted = false
            finishAnimation(withVelocity: velocity)
        }
    }
    
    @objc public func cancelGesture() {
        cancel()
    }
    
    public func scrollPanGesture(_ ypos:CGFloat) {
        guard attributesDelegate.popupShouldBeganDismiss else { return }
            
        let translationY = ypos
        currentPercent = min(max(translationY/(presentedViewController?.view.frame.size.height ?? 0), 0), 1)
        
        if let start = transitioningDelegate?.isInteractiveDismissStarted {
        
            if !start {
                transitioningDelegate?.isInteractiveDismissStarted = true
                presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
        
        update(currentPercent)
    }
    
}
