import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 화면 - 이메일 인증
 */
class JoinEmailViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIImageView!
    
    /** 이메일 */
    @IBOutlet weak var tvEmailTitle: UILabel!
    @IBOutlet weak var tvEmailField: TweeTextField!
    @IBOutlet weak var tvEmailAlert: UILabel!
    
    /** 인증번호 전송 버튼 */
    @IBOutlet weak var btnAuth: BaseButton!
    
    /** 인증번호 뷰 */
    @IBOutlet weak var checkPwView: UIView!
    
    /** 인증번호 */
    @IBOutlet weak var tvAuthTitle: UILabel!
    @IBOutlet weak var tvAuthField: TweeTextField!
    @IBOutlet weak var tvAuthAlert: UILabel!
    
    /** 인증번호 확인 버튼 */
    @IBOutlet weak var btnCheckAuth: BaseButton!
    
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
