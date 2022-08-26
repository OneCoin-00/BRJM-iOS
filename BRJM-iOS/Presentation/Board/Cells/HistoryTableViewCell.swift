import UIKit


/**
 - note: History Table View Cell 설정
 */
class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnReSearch: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tvTitle.textColor = BaseConstraint.COLOR_GRAY
        tvTitle.setFont(type: .regular, size: 16)
        
        bottomLineView.backgroundColor = BaseConstraint.COLOR_LIGHT_GRAY
    }
    
    /** 셀 설정 */
    public func setUpCell(data: BoardModel.History) {
        
        tvTitle.text = data.searchText
    }
}
