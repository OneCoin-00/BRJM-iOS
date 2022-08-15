import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 화면 - 비밀번호 입력
 */
class PasswordViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    /** 비밀번호 */
    @IBOutlet weak var tvPwTitle: UILabel!
    @IBOutlet weak var tvPwField: TweeTextField!
    @IBOutlet weak var tvPwAlert: UILabel!
    
    /** 비밀번호 확인 */
    @IBOutlet weak var tvCheckPwTitle: UILabel!
    @IBOutlet weak var tvCheckPwField: TweeTextField!
    @IBOutlet weak var tvCheckPwAlert: UILabel!
    
    /** 비밀번호 확인 버튼 */
    @IBOutlet weak var btnCheckPw: BaseButton!
    
    
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
        setNavigationBar(label: tvNavigationTitle, button: btnBack, title: "join_text_1".localized())
        
        
        /** 비밀번호 타이틀 */
        tvPwTitle.text = "join_text_8".localized()
        tvPwTitle.textColor = BaseConstraint.COLOR_GRAY
        tvPwTitle.setFont(type: .regular, size: 16)
        
        /** 비밀번호 필드 */
        tvPwField.keyboardType = .default
        tvPwField.placeholder = String(format: "join_text_3".localized(), "join_text_8".localized())
        
        /** 비밀번호 알림 */
        tvPwAlert.text = "join_text_10".localized()
        tvPwAlert.textColor = BaseConstraint.COLOR_GRAY
        tvPwAlert.setFont(type: .regular, size: 14)
        
        
        /** 비밀번호 확인 타이틀 */
        tvCheckPwTitle.text = "join_text_9".localized()
        tvCheckPwTitle.textColor = BaseConstraint.COLOR_GRAY
        tvCheckPwTitle.setFont(type: .regular, size: 16)
        
        /** 비밀번호 확인 필드 */
        tvCheckPwField.isEnabled = false
        tvCheckPwField.keyboardType = .default
        tvCheckPwField.placeholder = String(format: "join_text_3".localized(), "join_text_8".localized())
        
        /** 비밀번호 확인 알림 */
        tvCheckPwAlert.text = ""
        tvCheckPwAlert.setFont(type: .regular, size: 14)
        
        /** 비밀번호 확인 버튼 */
        setButton(false)
    }
    
    /** Rx 설정 */
    private func setRx() {
        
        /** 뒤로가기 버튼 클릭 */
        btnBack.rx.tap.bind {
            
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        /** 비밀번호 입력 감지 */
        tvPwField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkPassword()
        }).disposed(by: disposeBag)
        
        /** 비밀번호 필드 삭제 버튼 클릭 */
        tvPwField.deleteTapped = {
            
            self.checkPassword()
        }
        
        /** 비밀번호 확인 입력 감지 */
        tvCheckPwField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkEqualPassword()
        }).disposed(by: disposeBag)
        
        /** 비밀번호 확인 필드 삭제 버튼 클릭 */
        tvCheckPwField.deleteTapped = {
            
            self.checkEqualPassword()
        }
        
        /** 확인 버튼 클릭 */
        btnCheckPw.rx.tap.bind {
            
            self.moveToProfile()
        }.disposed(by: disposeBag)
    }
    
    /** 확인 버튼 설정*/
    private func setButton(_ isActive: Bool) {
        
        btnCheckPw.setTitle("confirm".localized())
        
        /** 버튼 클릭 활성화 */
        if isActive {
            btnCheckPw.isEnabled = true
            fullButton(btnCheckPw, backgroundColor: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 버튼 클릭 비활성화 */
        else {
            btnCheckPw.isEnabled = false
            lineButton(btnCheckPw, lineColor: BaseConstraint.COLOR_PRIMARY)
        }
    }
    
    /** 비밀번호 유효성 체크 */
    private func checkPassword() {
        
        /** 사용 가능 */
        if ValidateUtils.shared().checkPassword(str: tvPwField.text!) {
            
            tvPwAlert.text = "join_text_11".localized()
            tvPwAlert.textColor = BaseConstraint.COLOR_PRIMARY
            
            tvCheckPwField.isEnabled = true
            
            setTextFieldLine(textField: tvPwField, color: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 사용 불가능 */
        else {
            tvPwAlert.text = "join_text_10".localized()
            tvPwAlert.textColor = BaseConstraint.COLOR_RED
            
            tvCheckPwField.isEnabled = false
            
            setTextFieldLine(textField: tvPwField, color: BaseConstraint.COLOR_RED)
        }
        
        /** 비어있는 경우 */
        if tvPwField.text!.count == 0 {
            
            tvPwAlert.text = "join_text_10".localized()
            tvPwAlert.textColor = BaseConstraint.COLOR_GRAY
            
            tvCheckPwField.isEnabled = false
            
            setTextFieldLine(textField: tvPwField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
    }
    
    /** 비밀번호 동일 여부 확인 */
    private func checkEqualPassword() {
        
        if tvPwField.text!.count != 0 {
            
            /** 동일한 경우 */
            if tvPwField.text! == tvCheckPwField.text! {
                
                tvCheckPwAlert.text = "join_text_12".localized()
                tvCheckPwAlert.textColor = BaseConstraint.COLOR_PRIMARY
                
                setButton(true)
                setTextFieldLine(textField: tvCheckPwField, color: BaseConstraint.COLOR_PRIMARY)
            }
            
            /** 동일하지 않은 경우 */
            else {
                tvCheckPwAlert.text = "join_text_13".localized()
                tvCheckPwAlert.textColor = BaseConstraint.COLOR_RED
                
                setButton(false)
                setTextFieldLine(textField: tvCheckPwField, color: BaseConstraint.COLOR_RED)
            }
        }
        
        /** 비어있는 경우 */
        if tvCheckPwAlert.text!.count == 0 {
            
            tvCheckPwAlert.text = ""
            tvCheckPwAlert.textColor = BaseConstraint.COLOR_GRAY
            
            setTextFieldLine(textField: tvPwField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
    }
    
    /** 텍스트 필드 라인 색상 설정 */
    private func setTextFieldLine(textField: TweeTextField, color: UIColor) {
        
        textField.lineColor = color
        textField.activeLineColor = color
    }
    
    /** 회원가입으로 이동 (프로필 설정) */
    private func moveToProfile() {
        if let nvc = self.navigationController {
            
            if !(nvc.topViewController?.description.contains("ProfileViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "MemberScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                vc.modalTransitionStyle = .crossDissolve
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
}
