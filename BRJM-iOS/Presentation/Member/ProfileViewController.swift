import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 회원가입 화면 - 프로필 설정
 */
class ProfileViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    /** 프로필 이미지 버튼 */
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    
    /** 닉네임 */
    @IBOutlet weak var tvNickTitle: UILabel!
    @IBOutlet weak var tvNickField: TweeTextField!
    @IBOutlet weak var btnCheckNick: UIButton!
    
    /** 카테고리 */
    @IBOutlet weak var tvCategoryTitle: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    /** 회원가입 버튼 */
    @IBOutlet weak var btnJoin: UIButton!
    
    /** 프로퍼티 */
    var useNick: Bool = false/** 닉네임 사용 여부 */
    
    
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
        
        
        /** 프로필 이미지 */
        ivProfile.layer.cornerRadius = ivProfile.width / 2
        ivProfile.image = UIImage(named: "icDefaultProfile")
        
        
        /** 닉네임 타이틀 */
        tvNickTitle.text = "join_text_14".localized()
        tvNickTitle.textColor = BaseConstraint.COLOR_GRAY
        tvNickTitle.setFont(type: .regular, size: 16)
        
        /** 닉네임 필드 */
        tvNickField.keyboardType = .default
        tvNickField.placeholder = String(format: "join_text_3".localized(), "join_text_14".localized())
        
        /** 닉네임 확인 버튼 */
        useNickname(useNick)
        
        
        /** 카테고리 타이틀 */
        tvCategoryTitle.isHidden = true
        tvCategoryTitle.text = "join_text_15".localized()
        tvCategoryTitle.textColor = .black
        tvCategoryTitle.setFont(type: .bold, size: 18)
        
        /** 카테고리 컬렉션 뷰 */
        categoryCollectionView.isHidden = true
        //categoryCollectionView.delegate = self
        
        
        /** 회원가입 버튼 */
        setButton(true)
    }
    
    /** Rx 설정 */
    private func setRx() {
        
        /** 뒤로가기 버튼 클릭 */
        btnBack.rx.tap.bind {
            
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        /** 닉네임 입력 감지 */
        tvNickField.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            self.checkNickname()
        }).disposed(by: disposeBag)
        
        /** 닉네임 필드 삭제 버튼 클릭 */
        tvNickField.deleteTapped = {
            
            self.checkNickname()
        }
        
        /** 닉네임 확인 버튼 클릭 */
        btnCheckNick.rx.tap.bind {
            
            if self.tvNickField.text!.count != 0 {
                self.useNick = true
            } else {
                self.useNick = false
            }
            
            self.useNickname(self.useNick)
        }.disposed(by: disposeBag)
        
        /** 확인 버튼 클릭 */
        btnJoin.rx.tap.bind {
            
            self.moveToHome()
        }.disposed(by: disposeBag)
    }
    
    /** 닉네임 유효성 확인 */
    private func checkNickname() {
        
        /** 비어있지 않은 경우 */
        if tvNickField.text!.count != 0 {
            setTextFieldLine(textField: tvNickField, color: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 비어있는 경우 */
        else {
            useNickname(false)
            setTextFieldLine(textField: tvNickField, color: BaseConstraint.COLOR_LIGHTE_GRAY)
        }
    }
    
    /** 닉네임 사용하기 */
    private func useNickname(_ isUse: Bool) {
        
        /** 사용하기 */
        if isUse {
            tvCategoryTitle.isHidden = false
            categoryCollectionView.isHidden = false
            
            btnCheckNick.setImage(UIImage(named: "icCheckNickActivate"))
        }
        
        /** 사용 안 함 */
        else {
            tvCategoryTitle.isHidden = true
            categoryCollectionView.isHidden = true
            
            btnCheckNick.setImage(UIImage(named: "icCheckNickDisactivate"))
        }
    }
    
    /** 텍스트 필드 라인 색상 설정 */
    private func setTextFieldLine(textField: TweeTextField, color: UIColor) {
        
        textField.lineColor = color
        textField.activeLineColor = color
    }
    
    /** 회원가입 버튼 설정*/
    private func setButton(_ isActive: Bool) {
        
        btnJoin.setTitle("join_text_1".localized())
        
        /** 버튼 클릭 활성화 */
        if isActive {
            btnJoin.isEnabled = true
            
            fullButton(btnJoin, backgroundColor: BaseConstraint.COLOR_PRIMARY)
        }
        
        /** 버튼 클릭 비활성화 */
        else {
            btnJoin.isEnabled = false
            lineButton(btnJoin, lineColor: BaseConstraint.COLOR_PRIMARY)
        }
    }
}
