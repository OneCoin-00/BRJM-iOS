import UIKit


/**
 - note: 환경소식 테이블 뷰 셀
 */
class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!/** 타이틀 */
    @IBOutlet weak var btnDetail: UIButton!/** 자세히보기 버튼 */
    @IBOutlet weak var bottomLineView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 타이틀 설정 */
        tvTitle.setFont(type: .regular, size: 15)
        /** 라인 뷰 설정 */
        bottomLineView.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    /** 셀 설정 */
    public func setUpCell(data: NewsModel.News) {
        
        tvTitle.text = data.title
    }
}
