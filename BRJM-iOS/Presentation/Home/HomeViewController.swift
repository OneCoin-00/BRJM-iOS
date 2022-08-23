import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 홈
 */
class HomeViewController : BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
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
        tvNavigationTitle.textColor = BaseConstraint.COLOR_LIGHTE_GRAY
        tvNavigationTitle.setFont(type: .regular, size: 14)
        
        /*
        /** 테이블 뷰 설정 */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardViewCell", bundle: nil), forCellReuseIdentifier: "CardViewCell")
        tableView.separatorStyle = .none
        
        /** footer 설정 */
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 34))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
         */
    }
}
