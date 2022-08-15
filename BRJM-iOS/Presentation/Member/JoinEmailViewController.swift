import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 화면 - 이메일 인증
 */
class JoinEmailViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    /** 이메일 */
    @IBOutlet weak var tvEmailTitle: UILabel!
    @IBOutlet weak var tvEmailField: TweeTextField!
    @IBOutlet weak var tvEmailAlert: UILabel!
    
    /** 인증번호 전송 버튼 */
    @IBOutlet weak var btnAuth: BaseButton!
    
    /** 인증번호 뷰 */
    @IBOutlet weak var authView: UIView!
    
    /** 인증번호 */
    @IBOutlet weak var tvAuthTitle: UILabel!
    @IBOutlet weak var tvAuthField: TweeTextField!
    @IBOutlet weak var tvAuthAlert: UILabel!
    
    /** 인증번호 확인 버튼 */
    @IBOutlet weak var btnCheckAuth: BaseButton!
    
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
        setRx()
    }
    
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, button: btnBack, title: "join_text_1".localized())
        
        
        /** 이메일 타이틀 */
        tvEmailTitle.text = "join_text_2".localized()
        tvEmailTitle.textColor = BaseConstraint.COLOR_GRAY
        tvEmailTitle.setFont(type: .regular, size: 16)
        
        /** 이메일 필드 */
        tvEmailField.keyboardType = .emailAddress
        tvEmailField.placeholder = String(format: "join_text_3".localized(), "join_text_2".localized())
        
        /** 이메일 알림 */
        tvEmailAlert.text = ""
        tvEmailAlert.setFont(type: .regular, size: 14)
        
        /** 인증번호 버튼 */
        setButton(isActive: false, isEmail: true, button: btnAuth)
        
        
        /** 인증번호 뷰 */
        authView.isHidden = true
        btnCheckAuth.isHidden = true
        
        /** 인증번호 타이틀 */
        tvAuthTitle.text = "join_text_6".localized()
        tvAuthTitle.textColor = BaseConstraint.COLOR_GRAY
        tvAuthTitle.setFont(type: .regular, size: 16)
        
        /** 인증번호 필드 */
        tvAuthField.keyboardType = .numberPad
        tvAuthField.placeholder = String(format: "join_text_3".localized(), "join_text_6".localized())
        
        /** 인증번호 알림 */
        tvAuthAlert.text = " "
        tvAuthAlert.setFont(type: .regular, size: 14)
        
        /** 인증번호 전송 버튼 */
        setButton(isActive: false, isEmail: false, button: btnCheckAuth)
    }
    
    /** Rx 설정 */
    private func setRx() {
        
        /** 뒤로가기 버튼 클릭 */
        btnBack.rx.tap.bind {
            
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        
        /** 이메일 입력 감지 */
        tvEmailField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkEmail()
        }).disposed(by: disposeBag)
        
        /** 이메일 필드 삭제 버튼 클릭 */
        tvEmailField.deleteTapped = {
            
            self.tvEmailAlert.text = ""
            
            self.setButton(isActive: false, isEmail: true, button: self.btnAuth)
            self.setTextFieldLine(textField: self.tvEmailField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
        
        /** 인증번호 버튼 클릭 */
        btnAuth.rx.tap.bind {
            
            self.view.endEditing(true)
            
            self.authView.isHidden = false
            self.btnCheckAuth.isHidden = false
            
            /** api에서 인증번호 전송 */
            
        }.disposed(by: disposeBag)
        
        
        /** 인증번호 입력 감지 */
        tvAuthField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkAuth()
        }).disposed(by: disposeBag)
        
        /** 인증번호 필드 삭제 버튼 클릭 */
        tvAuthField.deleteTapped = {

            self.checkAuth()
        }
        
        /** 확인 버튼 클릭 */
        btnCheckAuth.rx.tap.bind {
            
            self.view.endEditing(true)
            
            /** 인증번호 동일한 경우 */
            if self.tvAuthField.text == "0000" {
                self.moveToPassword()
            }
            
            /** 동일하지 않은 경우 */
            else {
                self.checkAuth(true)
            }
        }.disposed(by: disposeBag)
    }
    
    /** 버튼 설정*/
    private func setButton(isActive: Bool, isEmail: Bool, button: UIButton) {
        
        var title: String = ""
        
        /** 버튼에 따라 타이틀 설정 */
        if isEmail {
            title = "join_text_6".localized()
        } else {
            title = "confirm".localized()
        }
        
        button.setTitle(title)
        
        /** 버튼 클릭 활성화 */
        if isActive {
            button.isEnabled = true
            fullButton(button, backgroundColor: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 버튼 클릭 비활성화 */
        else {
            button.isEnabled = false
            lineButton(button, lineColor: BaseConstraint.COLOR_PRIMARY)
        }
    }
    
    /** 이메일 유효성 검사 */
    private func checkEmail() {
        
        /** 사용 가능 */
        if ValidateUtils.shared().checkEmail(str: tvEmailField.text!) {
            
            tvEmailAlert.text = "join_text_4".localized()
            tvEmailAlert.textColor = BaseConstraint.COLOR_PRIMARY
            
            setButton(isActive: true, isEmail: true, button: btnAuth)
            setTextFieldLine(textField: tvEmailField, color: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 불가능 */
        else {
            tvEmailAlert.text = "join_text_5".localized()
            tvEmailAlert.textColor = BaseConstraint.COLOR_RED
            
            setButton(isActive: false, isEmail: true, button: btnAuth)
            setTextFieldLine(textField: tvEmailField, color: BaseConstraint.COLOR_RED)
        }
        
        /** 비어있는 경우 */
        if tvEmailField.text!.count == 0 {
            
            tvEmailAlert.text = ""
            
            setButton(isActive: false, isEmail: true, button: btnAuth)
            setTextFieldLine(textField: tvEmailField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
    }
    
    /** 인증번호 유효성 검사 */
    private func checkAuth(_ isFailure: Bool = false) {
        
        /** 비어있는 경우 */
        if tvAuthField.text!.count == 0 {
            
            tvAuthAlert.text = ""
            
            setButton(isActive: false, isEmail: false, button: btnCheckAuth)
            setTextFieldLine(textField: tvAuthField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
        
        /** 비어있지 않은 경우 */
        else {
            tvAuthAlert.text = ""
            
            setButton(isActive: true, isEmail: false, button: btnCheckAuth)
            setTextFieldLine(textField: tvAuthField, color: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 동일하지 않은 경우 */
        if isFailure {
            tvAuthAlert.text = "join_text_7".localized()
            tvAuthAlert.textColor = BaseConstraint.COLOR_RED
            
            setTextFieldLine(textField: tvAuthField, color: BaseConstraint.COLOR_RED)
        }
    }
    
    /** 텍스트 필드 라인 색상 설정 */
    private func setTextFieldLine(textField: TweeTextField, color: UIColor) {
        
        textField.lineColor = color
        textField.activeLineColor = color
    }
    
    /** 회원가입으로 이동 (비밀번호 설정) */
    private func moveToPassword() {
        if let nvc = self.navigationController {
            
            if !(nvc.topViewController?.description.contains("PasswordViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "MemberScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PasswordViewController") as! PasswordViewController
                vc.modalTransitionStyle = .crossDissolve
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
}
