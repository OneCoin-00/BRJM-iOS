import UIKit


/**
 - note: Card Cell 설정
 */
class CardCell: UICollectionViewCell {

    /** 게시글 */
    @IBOutlet weak var ivPost: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var tvPostTitle: UILabel!
    
    /** 정보 */
    @IBOutlet weak var tvWriter: UILabel!
    @IBOutlet weak var tvViews: UILabel!
    @IBOutlet weak var tvLikes: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /* 이미지 */
        ivPost.layer.cornerRadius = 4
        
        /** 타이틀 */
        tvPostTitle.textColor = .black
        tvPostTitle.setFont(type: .regular, size: 14)
        
        
        /** 작성자 */
        tvWriter.textColor = .black
        tvWriter.setFont(type: .regular, size: 10)
        
        /** 조회수 */
        tvViews.textColor = .black
        tvViews.setFont(type: .regular, size: 10)
        
        /** 좋아요 수 */
        tvLikes.textColor = .black
        tvLikes.setFont(type: .regular, size: 10)
    }
    
    /** 셀 설정 */
    public func setUpCell(data: BoardModel.Post) {
        
        if data.imageURL != "" {
            setNukeImage(url: data.imageURL, iv: ivPost) { image in }
        }
        
        btnLike.isSelected = data.isLiked
        tvPostTitle.text = data.title
        tvWriter.text = data.writer
        tvViews.text = data.views
        tvLikes.text = data.likes
    }

}
