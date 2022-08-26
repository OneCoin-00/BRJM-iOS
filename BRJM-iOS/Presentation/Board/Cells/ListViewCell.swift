import UIKit


/**
 - note: List View Cell 설정
 */
class ListViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var tvDesc: UILabel!
    @IBOutlet weak var tvWriter: UILabel!
    @IBOutlet weak var tvViews: UILabel!
    @IBOutlet weak var tvLikes: UILabel!
    
    @IBOutlet weak var ivPost: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnDetail: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 타이틀 */
        tvTitle.textColor = .black
        tvTitle.setFont(type: .bold, size: 16)
        
        /** 설명 */
        tvDesc.textColor = .black
        tvDesc.setFont(type: .regular, size: 12)
        
        /** 작성자 */
        tvWriter.textColor = .black
        tvWriter.setFont(type: .regular, size: 12)
        
        /** 조회수 */
        tvViews.textColor = .black
        tvViews.setFont(type: .regular, size: 10)
        
        /** 좋아요 수 */
        tvLikes.textColor = .black
        tvLikes.setFont(type: .regular, size: 10)
        
        /** 이미지 */
        ivPost.layer.cornerRadius = 4
    }
    
    /** 셀 설정 */
    public func setUpCell(data: BoardModel.Post) {
        
        tvTitle.text = data.title
        tvDesc.text = data.description
        tvWriter.text = data.writer
        tvViews.text = data.views
        tvLikes.text = data.likes
        btnLike.isSelected = data.isLiked
        
        if data.imageURL != "" {
            setNukeImage(url: data.imageURL, iv: ivPost) { image in }
        }
    }
}
