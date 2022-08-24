import UIKit


/**
 - note: Ranking View Cell 설정
 */
class RankingViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /** 프로퍼티 */
    private var postList:[BoardModel.Post] = []/** 게시글 리스트 */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 뷰 설정 */
        setViews()
        setData()
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 타이틀 */
        tvTitle.textColor = .black
        tvTitle.setFont(type: .bold, size: 18)
        
        /** 컬렉션 뷰 */
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(RankingCell.self)
        
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<3 {
            let data = BoardModel.Post()
            data.title = "테스트 데이터 \(i)"
            data.writer = "rlanwjd"
            data.views = "150 views"
            data.likes = "37 likes"
            data.imageURL = "https://story.holapet.com/wp-content/uploads/2021/03/7-2.jpg"
            
            postList.append(data)
        }
    }
}


extension RankingViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let data = postList[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingCell", for: indexPath) as! RankingCell
        
        cell.setUpCell(data: data, index: index)
        
        cell.btnLike.tag = index
        cell.btnLike.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /** 게시글 보기 페이지로 이동*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 108
        
        return CGSize(width: width, height: height)
    }
    
    /** 찜 탭 */
    @objc private func likeTapped(_ sender: UIButton) {
        
        let index = sender.tag
        let data = postList[index]
        let likeValue = data.isLiked
        
        data.isLiked = !likeValue
        postList[index].isLiked = data.isLiked
        
        collectionView.reloadData()
    }
}
