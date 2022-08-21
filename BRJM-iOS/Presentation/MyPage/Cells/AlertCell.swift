import UIKit


/**
 - note: 마이페이지 알림 셀
 */
class AlertCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var ivAlert: UIImageView!
    @IBOutlet weak var bottomLineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 타이틀 */
        tvTitle.textColor = .black
        tvTitle.setFont(type: .regular, size: 12)
        
        /** 새로운 알림 */
        ivAlert.isHidden = false
        
        /** 하단 라인 뷰 */
        bottomLineView.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
    }
    
    /** 셀 설정 */
    public func setUpCell(data: MyPageModel.Alert) {
        
        tvTitle.text = data.title
        ivAlert.isHidden = data.isSee
    }
}
