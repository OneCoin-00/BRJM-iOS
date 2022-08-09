import UIKit
import RxCocoa
import RxSwift


/**
 - note: 공통 - 버튼2개 팝업
 */
class ConfirmPopupView: BaseViewController {
    
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvDescription: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    public var cancelClick: (() -> ())?
    public var confirmClick: (() -> ())?
    
    public var titleString:String!
    public var descriptionString:String!
    public var cancelString:String!
    public var confirmString:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 취소 클릭 */
        btnCancel.rx.tap.bind {
            self.dismiss(animated: true) {
                self.cancelClick!()
            }
        }.disposed(by: disposeBag)
        
        
        /** 확인 클릭 */
        btnConfirm.rx.tap.bind {
            self.dismiss(animated: true) {
                self.confirmClick!()
            }
        }.disposed(by: disposeBag)
        
        /** 글자 설정 */
        setText()
    }
    
    private func setText() {
        
        if "" != titleString {
            tvTitle.text = titleString
            tvTitle.isHidden = false
        } else {
            tvTitle.isHidden = true
        }
        
        if "" != descriptionString {
            tvDescription.text = descriptionString
            tvDescription.isHidden = false
        } else {
            tvDescription.isHidden = true
        }
        
        tvTitle.setLineSpacing(lineSpacing: 27, kern: 0)
        tvDescription.setLineSpacing(lineSpacing: 27, kern: 0)
        btnCancel.setTitle(cancelString)
        btnConfirm.setTitle(confirmString)
    }
}
