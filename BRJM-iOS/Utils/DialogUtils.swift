import Foundation
import UIKit


/**
 - Note: 공통 다이얼로그 유틸리티
 */
class DialogUtils {
    
    private static var _shared: DialogUtils = {
        
        let obj = DialogUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> DialogUtils {
        return _shared
    }
    
    private var alertDialog:AlertPopupView!                     /** (공통) 팝업 - 확인 */
    private var confirmDialog:ConfirmPopupView!                 /** (공통) 팝업 - 취소/확인 */
    
    
    /**
     - Note: (공통) 팝업
     */
    public func alertPopup(title:String, buttonString:String = "confirm".localized(), confirmCallback:@escaping ()->()) {
        
        DispatchQueue.main.async {
            [self] in
            
            if alertDialog != nil { alertDialog.dismiss(animated: false, completion: nil) }
            alertDialog = (UIStoryboard.init(name: "CommonScreen", bundle: nil).instantiateViewController(withIdentifier: "AlertPopupView") as! AlertPopupView)
            alertDialog.modalTransitionStyle = .crossDissolve
            alertDialog.modalPresentationStyle = .overCurrentContext
            
            alertDialog.titleString = title
            alertDialog.buttonString = buttonString
            
            alertDialog.confirmClick = { () -> () in
                confirmCallback()
            }
            
            UIApplication.topViewController()?.present(alertDialog, animated: true, completion: nil)
        }
    }
       
    /**
     - Note: (공통) 팝업
     */
    public func confirmPopup(title:String = "", message:String = "", cancelString:String = "cancel".localized(), confirmString:String = "confirm".localized(), cancelCallback:@escaping ()->(), confirmCallback:@escaping ()->()) {
           
        DispatchQueue.main.async {
            [self] in
            
            if confirmDialog != nil { confirmDialog.dismiss(animated: false, completion: nil) }
            confirmDialog = (UIStoryboard.init(name: "CommonScreen", bundle: nil).instantiateViewController(withIdentifier: "ConfirmPopupView") as! ConfirmPopupView)
            confirmDialog.modalTransitionStyle = .crossDissolve
            confirmDialog.modalPresentationStyle = .overCurrentContext
            
            confirmDialog.titleString = title
            confirmDialog.descriptionString = message
            confirmDialog.cancelString = cancelString
            confirmDialog.confirmString = confirmString
            
            confirmDialog.cancelClick = { () -> () in
                cancelCallback()
            }
            confirmDialog.confirmClick = { () -> () in
                confirmCallback()
            }
            
            UIApplication.topViewController()?.present(confirmDialog, animated: true, completion: nil)
        }
    }
}
