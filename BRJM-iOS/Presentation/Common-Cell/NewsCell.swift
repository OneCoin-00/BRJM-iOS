import UIKit


/**
 - note: News Cell 설정
 */
class NewsCell: UICollectionViewCell {

    @IBOutlet weak var ivNews: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var btnMore: BaseButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 이미지 */
        ivNews.layer.cornerRadius = 8
        
        /** 타이틀 */
        tvTitle.textColor = .black
        tvTitle.setFont(type: .bold, size: 12)
        
        /** 버튼 */
        btnMore.setTitleColor(.white)
        btnMore.setFont(type: .regular, size: 8)
        btnMore.backgroundColor = .black
        btnMore.layer.opacity = 0.45
    }
    
    /** 셀 설정 */
    public func setUpCell() {
        
    }
}
