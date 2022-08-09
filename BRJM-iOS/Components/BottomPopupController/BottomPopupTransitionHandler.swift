import UIKit

final class BottomPopupTransitionHandler: NSObject, UIViewControllerTransitioningDelegate {
    private let presentAnimator: BottomPopupPresentAnimator
    private let dismissAnimator: BottomPopupDismissAnimator
    private var interactionController: BottomPopupDismissInteractionController?
    private unowned var popupViewController: BottomPresentableViewController
    fileprivate weak var popupDelegate: BottomPopupDelegate?
    
    var isInteractiveDismissStarted = false
    
    init(popupViewController: BottomPresentableViewController) {
        self.popupViewController = popupViewController
        
        presentAnimator = BottomPopupPresentAnimator(attributesOwner: popupViewController)
        dismissAnimator = BottomPopupDismissAnimator(attributesOwner: popupViewController)
    }
    
    //MARK: Public
    func notifyViewLoaded(withPopupDelegate delegate: BottomPopupDelegate?) {
        self.popupDelegate = delegate
        if popupViewController.popupShouldDismissInteractivelty {
            interactionController = BottomPopupDismissInteractionController(presentedViewController: popupViewController, attributesDelegate: popupViewController)
            interactionController?.delegate = self
        }
    }
    
    //MARK: Specific animators
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomPopupPresentationController(presentedViewController: presented, presenting: presenting, attributesDelegate: popupViewController)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractiveDismissStarted ? interactionController : nil
    }
    
    public func chanageInteractiveDismissStarted(bool:Bool) {
        isInteractiveDismissStarted = bool
    }
    
    // # Custom
    public func changePreparePanGesture(view:UIView) {
        interactionController?.preparePanGesture(in: view)
    }
    
    public func handlePanGesture(_ pan: UIPanGestureRecognizer) {
        interactionController?.handlePanGesture(pan)
    }
    
    public func cancelGesture() {
        interactionController?.cancelGesture()
    }
    
    public func scrollPanGesture(_ ypos:CGFloat) {
        interactionController?.scrollPanGesture(ypos)
    }
}

extension BottomPopupTransitionHandler: BottomPopupDismissInteractionControllerDelegate {
    func dismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        popupDelegate?.bottomPopupDismissInteractionPercentChanged(from: oldValue, to: newValue)
    }
}
