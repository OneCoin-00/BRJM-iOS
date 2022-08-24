import UIKit


/**
 - note: News View Cell 설정
 */
class NewsViewCell: UITableViewCell {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    /** 프로퍼티 */
    private var newsList:[NewsModel.News] = []/** 환경소식 리스트 */
    
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(NewsCell.self)
        
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = .fast
        collectionView.showsHorizontalScrollIndicator = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 150
        
        return CGSize(width: width, height: height)
    }
}
