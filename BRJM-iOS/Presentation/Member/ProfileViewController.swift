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
    @IBOutlet weak var tvProfileTitle: UILabel!
    
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
    private var categoryList: [HomeModel.Category] = []/** 카테고리 리스트 */
    private var useNick: Bool = false/** 닉네임 사용 여부 */
    
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

        /** 데이터 설정 */
        setCategory()
        
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
        
        /** 이미지 업로드 버튼 */
        btnProfile.setImage(UIImage(named: "icUploadImage"))
        
        /** 이미지 업로드 버튼 타이틀*/
        tvProfileTitle.text = "join_text_16".localized()
        tvProfileTitle.textColor = BaseConstraint.COLOR_GRAY
        tvProfileTitle.setFont(type: .bold, size: 10)
        
        
        /** 닉네임 타이틀 */
        tvNickTitle.text = "join_text_14".localized()
        tvNickTitle.textColor = BaseConstraint.COLOR_GRAY_80
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
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.registerReusableCell(CategoryCell.self)
        
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
    
    /** 카테고리 설정 */
    private func setCategory() {
        
        for i in 1...8 {
            let data = HomeModel.Category()
            data.title = "icCategory\(i)"
            
            categoryList.append(data)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let data = categoryList[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.ID, for: indexPath) as! CategoryCell
        
        cell.setCells(data, index: index + 1)
        
        cell.btnCategory.tag = index
        cell.btnCategory.addTarget(self, action: #selector(selectedCategory(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    /** 셀 사이즈 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: (categoryCollectionView.height - 12) / 2)
    }
    
    /** 셀 줄 간격 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    /** 셀 간격 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (categoryCollectionView.width / 4) / 5
    }
    
    /** 카테고리 선택 */
    @objc private func selectedCategory(_ sender: UIButton) {
        
        let index = sender.tag
        let data = categoryList[index]
        let selectValue = data.isSelected
        
        data.isSelected = !selectValue
        
        categoryCollectionView.reloadData()
    }
}
