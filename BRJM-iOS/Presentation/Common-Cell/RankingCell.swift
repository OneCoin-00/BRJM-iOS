import UIKit


/**
 - note: Ranking Cell 설정
 */
class RankingCell: UICollectionViewCell {
    
    @IBOutlet weak var ivPost: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvWriter: UILabel!
    @IBOutlet weak var tvViews: UILabel!
    @IBOutlet weak var tvLikes: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var ivInsignia: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 이미지 */
        ivPost.layer.cornerRadius = 4
        
        /** 타이틀 */
        tvTitle.textColor = .black
        tvTitle.setFont(type: .bold, size: 14)
        
        /** 작성자 */
        tvWriter.textColor = .black
        tvWriter.setFont(type: .regular, size: 12)
        
        /** 조회수 */
        tvViews.textColor = .black
        tvViews.setFont(type: .regular, size: 10)
        
        /** 좋아요 수 */
        tvLikes.textColor = .black
        tvLikes.setFont(type: .regular, size: 10)
        
        /** 휘장 이미지 */
        ivInsignia.image = UIImage(named: "icInsignia1")
    }

    /** 셀 설정 */
    public func setUpCell(data: BoardModel.Post, index: Int) {
        
        if data.imageURL != "" {
            setNukeImage(url: data.imageURL, iv: ivPost) { image in }
        }
        
        btnLike.isSelected = data.isLiked
        tvTitle.text = data.title
        tvWriter.text = data.writer
        tvViews.text = data.views
        tvLikes.text = data.likes
        ivInsignia.image = UIImage(named: "icInsignia\(index + 1)")
    }
}
