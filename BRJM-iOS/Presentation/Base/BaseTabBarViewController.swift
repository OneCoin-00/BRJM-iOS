import RxSwift
import RxCocoa
import UIKit
import MaterialComponents.MaterialBottomSheet


/**
 - Note: BaseTabBarViewController
 */
public class BaseTabBarViewController: UITabBarController {
    
    var disposeBag = DisposeBag()
    var bottomSheet:MDCBottomSheetController!
    
    
    lazy private(set) var classNameString: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        
        #if DEBUG
        print("DEINIT \(self.classNameString)")
        #endif
    }
    
    var isStatusBarHidden: Bool = false
    var params: [String: Any] = [:]
    public let hapticImapact = UIImpactFeedbackGenerator()
    
    
    override public var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // fallback on earlier versions
        }
        
        // 파라미터
        params = Session.shared().getParams()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 파라미터
        params = Session.shared().getParams()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /**
     - note: 뷰컨트롤러 활성화(화면 업데이트)
     */
    public func active() {
    }
    
    public func deactive() {
    }
    
    
    /**
     - note: Screen width
     */
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /**
     - note: Screen height
     */
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public func hideKeyboard(v:UIView) {
        v.endEditing(true)
    }
    
    // # 앱 종료
    public func quitApp() {
        
        // # 앱 종료
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                exit(0)
             }
        }
    }
}
