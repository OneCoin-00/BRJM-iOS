import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 화면 - 비밀번호 입력
 */
class PasswordViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIImageView!
    
    /** 비밀번호 */
    @IBOutlet weak var tvPwTitle: UILabel!
    @IBOutlet weak var tvPwField: TweeTextField!
    @IBOutlet weak var tvPwAlert: UILabel!
    
    /** 비밀번호 확인 뷰 */
    @IBOutlet weak var checkPwView: UIView!
    
    /** 비밀번호 확인 */
    @IBOutlet weak var tvCheckPwTitle: UILabel!
    @IBOutlet weak var tvCheckPwField: TweeTextField!
    @IBOutlet weak var tvCheckPwAlert: UILabel!
    
    /** 비밀번호 확인 버튼 */
    @IBOutlet weak var btnCheckPw: BaseButton!
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
