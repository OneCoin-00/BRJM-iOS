import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 홈
 */
class HomeViewController : BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    
    /** 컬렉션 뷰 */
    @IBOutlet weak var tableView: UITableView!
    
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 뷰 설정 */
        setViews()
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 타이틀 */
        tvNavigationTitle.text = "home_text_1".localized()
        tvNavigationTitle.textColor = BaseConstraint.COLOR_GRAY
        tvNavigationTitle.setFont(type: .regular, size: 14)
        
        /** 네비게이션 뷰 */
        searchView.layer.cornerRadius = 8
        searchView.layer.opacity = 0.21
        searchView.backgroundColor = BaseConstraint.COLOR_GRAY
        
        /** 테이블 뷰 설정 */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        tableView.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: "CategoryViewCell")
        tableView.register(UINib(nibName: "RankingViewCell", bundle: nil), forCellReuseIdentifier: "RankingViewCell")
        tableView.register(UINib(nibName: "RecommendViewCell", bundle: nil), forCellReuseIdentifier: "RecommendViewCell")
        tableView.separatorStyle = .none
        
        /** footer 설정 */
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 34))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
        
        
        /** 검색 버튼 클릭 */
        btnSearch.rx.tap.bind {
            self.moveToSearchView()
        }.disposed(by: disposeBag)
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath as IndexPath) as! NewsViewCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell", for: indexPath as IndexPath) as! CategoryViewCell
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "RankingViewCell", for: indexPath as IndexPath) as! RankingViewCell
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "RecommendViewCell", for: indexPath as IndexPath) as! RecommendViewCell
        default:
            return cell
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 189
        case 1:
            return 211
        case 2:
            return 190
        case 3:
            let count: CGFloat = 5/** 데이터 개수 */
            let result: CGFloat = 24 + 27 + 217 * count + 23 * (count - 1) + 20
            return result
        default:
            return 0
        }
    }
}
