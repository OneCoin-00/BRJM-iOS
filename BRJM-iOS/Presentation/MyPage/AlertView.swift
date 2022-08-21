import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 마이페이지 - 알림 page1
 */
class AlertView: BaseViewController {

    /** 테이블 뷰 */
    @IBOutlet weak var tableView: UITableView!
    
    /** 프로퍼티 */
    private var alertList:[MyPageModel.Alert] = []/** 알림 리스트 */
    
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AlertCell", bundle: nil), forCellReuseIdentifier: "AlertCell")
        tableView.separatorStyle = .none
        
        /** footer 설정 */
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 34))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<10 {
            let data = MyPageModel.Alert()
            data.title = "테스트 데이터 \(i)"
            
            if i == 1 || i == 2 || i == 3 {
                data.isSee = true
            }
            
            alertList.append(data)
        }
    }
}

extension AlertView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let data = alertList[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath as IndexPath) as! AlertCell
        
        cell.setUpCell(data: data)
        
        cell.btnDelete.tag = index
        cell.btnDelete.addTarget(self, action: #selector(deleteAlert(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    /** 상세 페이지로 이동 */
    @objc private func deleteAlert(_ sender: UIButton) {
        
        let index = sender.tag
        
        alertList.remove(at: index)
        tableView.reloadData()
    }
}
