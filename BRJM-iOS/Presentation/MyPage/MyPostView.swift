import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 마이페이지 - 내가 쓴 글 page2
 */
class MyPostView: BaseViewController {

    /** 콜렉션 뷰 */
    @IBOutlet weak var collectionView: UICollectionView!
    
    /** 프로퍼티 */
    private var postList:[BoardModel.Post] = []/** 게시글 리스트 */
    
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()

        /** 뷰 설정 */
        setViews()
        setData()
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 테이블 뷰 설정 */
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(CardCell.self)
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<10 {
            let data = BoardModel.Post()
            data.title = "테스트 데이터 \(i)"
            data.writer = "rlanwjd"
            data.views = "150 views"
            data.likes = "37 likes"
            data.imageURL = "https://story.holapet.com/wp-content/uploads/2021/03/7-2.jpg"
            
            if i == 1 || i == 2 || i == 3 {
                data.isLiked = true
            }
            
            postList.append(data)
        }
    }

}


extension MyPostView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let data = postList[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        
        cell.setUpCell(data: data)
        
        cell.btnLike.tag = index
        cell.btnLike.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /** 게시글 보기 페이지로 이동*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 60
        let width: CGFloat = (collectionView.bounds.width - margin) / 2
        let height: CGFloat = 217
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 23, left: 20, bottom: 34, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
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
