import UIKit
import RxCocoa


/**
 - Note: 게시판
 */
class BoardViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    
    /** 정렬 */
    
    /** 테이블 뷰 */
    @IBOutlet weak var tableView: UITableView!
    
    /** 프로퍼티 */
    private var postList:[BoardModel.Post] = []/** 게시글 리스트 */
    
    
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
        setNavigationBar(label: tvNavigationTitle, title: "board_text_1".localized())
        
        
        /** 테이블 뷰 설정 */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        tableView.separatorStyle = .none
    }
    
    /** test data */
    private func setData() {
        
        for i in 0..<10 {
            let data = BoardModel.Post()
            data.title = "테스트 데이터 \(i)"
            data.description = "테스트 데이터"
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

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        let data = postList[index]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath as IndexPath) as! ListViewCell
        
        cell.setUpCell(data: data)
        
        cell.btnLike.tag = index
        cell.btnLike.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /** 상세 페이지로 이동*/
    }
    
    /** 찜 탭 */
    @objc private func likeTapped(_ sender: UIButton) {
        
        let index = sender.tag
        let data = postList[index]
        let likeValue = data.isLiked
        
        data.isLiked = !likeValue
        postList[index].isLiked = data.isLiked
        
        tableView.reloadData()
    }
}
