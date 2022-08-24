import UIKit

/**
 - Note: Category Cell
 */
class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCategory: UIButton!
    
    /** 프로퍼티 */
    static let ID = "CategoryCell"
    private var image: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    /** 셀 설정 */
    public func setCells(_ data: HomeModel.Category, index: Int) {
        
        /** 카테고리 선택 */
        if data.isSelected {
            image = data.title
        }
        
        /** 카테고리 선택 해제 */
        else {
            image = data.title + "\(index)"
        }
        
        btnCategory.setImage(UIImage(named: image))
    }
}
