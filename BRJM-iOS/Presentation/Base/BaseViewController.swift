import RxSwift
import RxCocoa
import UIKit
import Nuke


/**
 - Note: BaseViewController
 */
public class BaseViewController: UIViewController {
    
    public var disposeBag = DisposeBag()/** DisposeBag */
    public var params: [String: Any] = [:]/** ViewController 파라미터 전달 */
    public let hapticImapact = UIImpactFeedbackGenerator()/** 햅틱 */
    
    lazy private(set) var classNameString: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        print("DEINIT \(self.classNameString)")
    }
    
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // fallback on earlier versions
        }
        
        params = Session.shared().getParams()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        params = Session.shared().getParams()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        params = [:]
    }
    
    /**
     - Note: 뷰컨트롤러 활성화(화면 업데이트)
     */
    public func onActive() {
    }
    
    public func onDeactive() {
    }
    
    /**
     - Note: Screen Width
     */
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /**
     - Note: Screen Height
     */
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /**
     - Note: 뷰컨트롤러로 전달될 파라미터 설정
     - Parameters:
        - params: 파라미터 데이터
     */
    public func setParams(params: [String:Any]) {
        self.params = params
    }
    
    
    /**
     - Note: Hide Keyboard
     */
    public func hideKeyboard(v: UIView) {
        v.endEditing(true)
    }
    
    public func topViewController() -> UIViewController? {
        
        if let keyWindow = UIApplication.shared.keyWindow {

            if var viewController = keyWindow.rootViewController {

                while viewController.presentedViewController != nil {

                    viewController = viewController.presentedViewController!
                }
                return viewController
            }
        }

        return nil
    }
    
    /**
     - Note: 네비게이션 바 설정
     */
    public func setNavigationBar(label: UILabel, button: UIButton, title: String) {
        
        /** 타이틀 */
        label.text = title
        label.textColor = .black
        label.setFont(type: .regular, size: 18)
        
        /** 뒤로가기 버튼*/
        button.setImage(UIImage(named: "icNavigationBack"))
    }
    
    /**
     - Note: line 버튼
     */
    public func lineButton(_ button: UIButton, lineColor: UIColor) {
        button.setTitleColor(lineColor)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = lineColor.cgColor
        button.setBackgroundColor(.clear, for: .normal)
        
        button.setFont(type: .bold, size: 16)
    }
    
    /**
     - Note: full 버튼
     */
    public func fullButton(_ button: UIButton, backgroundColor: UIColor) {
        button.setTitleColor(.white)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0
        button.backgroundColor = backgroundColor
        button.setBackgroundColor(backgroundColor, for: .normal)
        
        button.setFont(type: .bold, size: 16)
    }
    
    /**
     - Note: 토스트 메세지
     - Parameters:
        - message: 메세지
        - withDuration: 애니메이션 시간
        - isTop: 상단 or 하단
     */
    public func showToast(message:String, withDuration:Double = 1, isTop: Bool = false) {
        
        let toastLabel = LabelWithPadding()
        toastLabel.padding(0, 0, 10, 10)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.numberOfLines = 1
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.leferiBase(.regular, size: 18)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 30;
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        
        var w = toastLabel.width + 40
        if w < 300 { w = 300; }
        
        var fromY = self.view.frame.size.height + 100
        if isTop {
            fromY = -100
        }
        var toY = self.view.frame.size.height - 100
        if isTop {
            toY = 100
        }
        
        toastLabel.frame = CGRect(x: self.view.frame.width/2 - w/2, y: 0, width: w, height: 60)
        toastLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y:fromY)
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.5
            settings.delay = 0
            settings.ease = .easeOutQuint
            return {
                toastLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: toY)
            }
        })
        
        UIApplication.topViewController()?.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: withDuration, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 1.0
            settings.delay = 2.0
            settings.ease = .easeOutQuint
            return {
                toastLabel.transform = CGAffineTransform.identity.translatedBy(x: 0, y: fromY)
            }
        })
    }
    
    /**
     - Note: 상단 토스트 메세지
     - Parameters:
        - message: 메세지
        - withDuration: 애니메이션 시간
     */
    public func showTopToast(message:String, withDuration:Double = 1) {
        
        let toastLabel = LabelWithPadding()
        toastLabel.padding(0, 0, 10, 10)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.numberOfLines = 1
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.leferiBase(.regular, size: 18)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 30;
        toastLabel.clipsToBounds = true
        toastLabel.sizeToFit()
        
        var w = toastLabel.width + 40
        if w < 300 { w = 300; }
        
        toastLabel.frame = CGRect(x: self.view.frame.width/2 - w/2, y: 0, width: w, height: 60)
        toastLabel.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(-100))
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 0.5
            settings.delay = 0
            settings.ease = .easeOutQuint
            return {
                toastLabel.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(100))
            }
        })
        
        UIApplication.topViewController()?.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: withDuration, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
        anim({ (settings) -> (animClosure) in
            settings.duration = 1.0
            settings.delay = 2.0
            settings.ease = .easeOutQuint
            return {
                toastLabel.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(0), y: CGFloat(100))
            }
        })
    }
    
    /**
     - note: 권한 오류 팝업
     */
    public func openPermissionError() -> Void {
        
        DialogUtils.shared().confirmPopup(title: "permission_error".localized()) {
        } confirmCallback: {
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }
    }
    
    /**
     - note: 오토 레이아웃
     */
    public func setAutoLayout(from:UIView, to:UIView) {
        from.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.init(item: from, attribute: .leading, relatedBy: .equal, toItem: to, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .trailing, relatedBy: .equal, toItem: to, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .top, relatedBy: .equal, toItem: to, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: from, attribute: .bottom, relatedBy: .equal, toItem: to, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        view.layoutIfNeeded()
    }
    
    
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
    
    
    /** 홈으로 이동 */
    public func moveToHome() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        
        window.rootViewController = {
        
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! HomeNavigationController
            
            return navigationController
        }()
    }
    
    
    /** 외부 링크로 이동 */
    public func globalMoveBrowser(link: String) {
        
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
            Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { (timer) in
                
            }
        }
    }
}
