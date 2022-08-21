import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 및 로그인 선택 화면
 */
class LoginViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    /** 이메일 */
    @IBOutlet weak var tvEmailTitle: UILabel!
    @IBOutlet weak var tvEmailField: TweeTextField!
    
    /** 비밀번호 */
    @IBOutlet weak var tvPwTitle: UILabel!
    @IBOutlet weak var tvPwField: TweeTextField!
    
    /** 로그인 or 비밀번호 오류 알림 **/
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var tvAlert: UILabel!
    
    /** 로그인 버튼 **/
    @IBOutlet weak var btnLogin: UIButton!
    
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

        /** 뷰 설정 */
        setViews()
        setRx()
    }

    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, button: btnBack, title: "login_text_1".localized())
        
        
        /** 이메일 */
        tvEmailTitle.text = "join_text_2".localized()
        tvEmailTitle.textColor = BaseConstraint.COLOR_GRAY
        tvEmailTitle.setFont(type: .regular, size: 16)
        
        /** 이메일 필드 */
        tvEmailField.keyboardType = .emailAddress
        tvEmailField.placeholder = String(format: "join_text_3".localized(), "join_text_2".localized())
        
        
        /** 비밀번호 타이틀 */
        tvPwTitle.text = "join_text_8".localized()
        tvPwTitle.textColor = BaseConstraint.COLOR_GRAY
        tvPwTitle.setFont(type: .regular, size: 16)
        
        /** 비밀번호 필드 */
        tvPwField.keyboardType = .default
        tvPwField.isSecureTextEntry = true
        tvPwField.placeholder = String(format: "join_text_3".localized(), "join_text_8".localized())

        
        /** 알림 뷰 */
        alertView.isHidden = true
        
        /** 알림 타이틀 **/
        tvAlert.text = "login_text_2".localized()
        tvAlert.textColor = BaseConstraint.COLOR_RED
        tvAlert.setFont(type: .regular, size: 14)
        
        
        /** 로그인 버튼 */
        setButton(isActive: false)
    }
    
    /** Rx 설정 */
    public func setRx() {
        
        /** 뒤로가기 버튼 클릭 */
        btnBack.rx.tap.bind {
            
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        
        /** 이메일 입력 감지 */
        tvEmailField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkEnterData()
        }).disposed(by: disposeBag)
        
        /** 이메일 필드 삭제 버튼 클릭 */
        tvEmailField.deleteTapped = {
            
            self.tvEmailField.text = ""
        }
        
        
        /** 비밀번호 입력 감지 */
        tvPwField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkEnterData()
        }).disposed(by: disposeBag)
        
        /** 비밀번호 필드 삭제 버튼 클릭 */
        tvPwField.deleteTapped = {
            
            self.tvPwField.text = ""
        }
        
        
        /** 로그인 버튼 클릭 */
        btnLogin.rx.tap.bind {
            
            if self.tvEmailField.text! == "fujeong15" && self.tvPwField.text! == "1234"{
                self.moveToHome()
            } else {
                self.alertView.isHidden = false
            }
        }.disposed(by: disposeBag)
    }
    
    /** 버튼 설정*/
    private func setButton(isActive: Bool) {
        
        btnLogin.setTitle("login_text_1".localized())
        
        /** 버튼 클릭 활성화 */
        if isActive {
            btnLogin.isEnabled = true
            fullButton(btnLogin, backgroundColor: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 버튼 클릭 비활성화 */
        else {
            btnLogin.isEnabled = false
            lineButton(btnLogin, lineColor: BaseConstraint.COLOR_PRIMARY)
        }
    }
    
    /** 입력 확인 */
    private func checkEnterData() {
        
        if !alertView.isHidden {
            alertView.isHidden = true
        }
        
        if !tvEmailField.text!.isEmpty && !tvPwField.text!.isEmpty {
            setButton(isActive: true)
        } else {
            setButton(isActive: false)
        }
    }
}
