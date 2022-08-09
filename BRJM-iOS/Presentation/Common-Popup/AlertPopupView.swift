import UIKit
import RxCocoa
import RxSwift


/**
 - note: 공통 - 버튼1개 팝업
 */
class AlertPopupView: BaseViewController {
    
    @IBOutlet weak var tvTitle: UILabel!
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    public var confirmClick: (() -> ())?
    
    public var titleString:String!
    public var buttonString:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tvTitle.text = titleString
        tvTitle.setLineSpacing(lineSpacing: 27, kern: 0)
        btnConfirm.setTitle(buttonString)
    }
}
