import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 및 로그인 선택 화면
 */
class MemberViewController : BaseViewController {

    @IBOutlet weak var btnJoin: BaseButton!
    @IBOutlet weak var btnLogin: BaseButton!
    
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnJoin.rx.tap.bind {
            
            self.moveToJoin()
        }.disposed(by: disposeBag)
        
        btnLogin.rx.tap.bind {
            self.moveToHome()
        }.disposed(by: disposeBag)
    }
    
    /** 회원가입으로 이동 (이메일 인증) */
    private func moveToJoin() {
        if let nvc = self.navigationController {
            
            if !(nvc.topViewController?.description.contains("JoinEmailViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "MemberScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "JoinEmailViewController") as! JoinEmailViewController
                vc.modalTransitionStyle = .crossDissolve
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
}
