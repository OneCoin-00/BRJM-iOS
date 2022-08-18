import UIKit
import RxCocoa


/**
 - Note: 환경 소식
 */
class NewsViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    
    /** 테이블 뷰 */
    @IBOutlet weak var tableView: UITableView!
    
    /** 프로퍼티 */
    private var newsList:[NewsModel.News] = []/** 환경소식 리스트 */
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 뷰 설정 */
        setViews()
        setData()
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, title: "news_text_1".localized())
        
        
        /** 테이블 뷰 설정 */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        tableView.separatorStyle = .none
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<10 {
            let data = NewsModel.News()
            data.title = "테스트 데이터 \(i)"
            data.url = "https://m.naver.com"
            
            newsList.append(data)
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let data = newsList[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath as IndexPath) as! ListTableViewCell
        
        cell.setUpCell(data: data)
        
        cell.btnDetail.tag = index
        cell.btnDetail.addTarget(self, action: #selector(moveToDetail(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    /** 상세 페이지로 이동 */
    @objc private func moveToDetail(_ sender: UIButton) {
        
        let index = sender.tag
        let data = newsList[index]
        
        self.moveToWebView(data.url)
    }
}
