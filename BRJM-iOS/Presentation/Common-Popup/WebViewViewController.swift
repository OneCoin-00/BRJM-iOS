import UIKit
import WebKit


class WebViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    /** 웹 뷰 */
    @IBOutlet weak var webGroupView: UIView!
    
    private var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = params["url"] as? String else { return }
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, button: btnBack, title: "news_text_2".localized())
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "bridge")
            
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        
        let request = URLRequest(url: URL(string: urlString)!)
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webGroupView.addSubview(webView)
        setAutoLayout(from: webView, to: webGroupView)
        webView.load(request)
        
        webView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.webView.alpha = 1
        }) { _ in
        }
    }
    
    @IBAction func backClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


///--------------------------------------------------
/// WKNavigationDelegate
///--------------------------------------------------
extension WebViewController: WKNavigationDelegate {
    
    /**
     - note: 유효한 도메인 체크
     */
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        CommonUtils.log("\(navigationAction.request.url?.absoluteString ?? "")" )
        
        decisionHandler(.allow)
    }
}

///--------------------------------------------------
/// WKUIDelegate
///--------------------------------------------------
extension WebViewController: WKUIDelegate {
    
    /**
     - note: Alert 다이얼로그 처리
     */
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }

    public func webViewDidClose(_ webView: WKWebView) {
        
    }
}

///--------------------------------------------------
/// WKScriptMessageHandler
///--------------------------------------------------
extension WebViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        CommonUtils.log( message.name )
    }
}
