import UIKit


/**
 - note: News View Cell 설정
 */
class NewsViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /** 프로퍼티 */
    private var newsList:[NewsModel.News] = []/** 환경소식 리스트 */
    
    var currentIndex: CGFloat = 0
    let lineSpacing: CGFloat = 20
    let cellRatio: CGFloat = 0.7
    var isOneStepPaging = true
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /** 뷰 설정 */
        setViews()
        setData()
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 타이틀 */
        tvTitle.text = "home_text_2".localized()
        tvTitle.textColor = .black
        tvTitle.setFont(type: .bold, size: 18)
        
        /** 컬렉션 뷰 */
        setCollectionView()
    }
    
    /** 컬렉션 뷰 */
    private func setCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(NewsCell.self)
        
        collectionView.isPagingEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 150)
        layout.minimumLineSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<15 {
            let data = NewsModel.News()
            data.title = "테스트 데이터 \(i)"
            data.imageURL = "https://story.holapet.com/wp-content/uploads/2021/03/7-2.jpg"
            data.url = "https://m.naver.com"
            
            newsList.append(data)
        }
    }
    
    /** 웹뷰로 이동 */
    public func moveToWebView(_ url: String) {
        
        if "" == url { return }
        
        if let nvc = UIApplication.topViewController()?.navigationController {
            
            if !(nvc.topViewController?.description.contains("WebViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "CommonScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                vc.modalTransitionStyle = .crossDissolve
                
                var pm: [String: Any] = [:]
                pm["url"] = url
                Session.shared().setParams(param: pm)
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        let index: Int
        
        if velocity.x > 0 {
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            index = Int(floor(estimatedIndex))
        } else {
            index = Int(round(estimatedIndex))
        }
        
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
    }
}


extension NewsViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let data = newsList[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.setUpCell(data: data, index: index, totalCount: newsList.count)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        let data = newsList[index]
        
        self.moveToWebView(data.url)
    }
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width - 20
        let height: CGFloat = 150
        
        return CGSize(width: width, height: height)
    }*/
}
