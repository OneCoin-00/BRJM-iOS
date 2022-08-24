import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 게시판
 */
class BoardViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    
    /** 정렬 */
    @IBOutlet weak var tvNew: UILabel!
    @IBOutlet weak var btnNew: BaseButton!
    
    @IBOutlet weak var tvView: UILabel!
    @IBOutlet weak var btnView: BaseButton!
    
    @IBOutlet weak var tvLike: UILabel!
    @IBOutlet weak var btnLike: BaseButton!
    
    /** 테이블 뷰 */
    @IBOutlet weak var tableView: UITableView!
    
    /** 프로퍼티 */
    private var postList:[BoardModel.Post] = []/** 게시글 리스트 */
    
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()

        /** 뷰 설정 */
        setViews()
        setRx()
        setData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, title: "board_text_1".localized())
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, title: "board_text_1".localized())
        
        
        /** 정렬 설정 */
        tvNew.textColor = .black
        tvNew.text = "board_text_2".localized()
        tvNew.setFont(type: .regular, size: 10)
        btnNew.layer.opacity = 0.3
        btnNew.layer.cornerRadius = 11
        
        tvView.textColor = .black
        tvView.text = "board_text_3".localized()
        tvView.setFont(type: .regular, size: 10)
        btnView.layer.opacity = 0.3
        btnView.layer.cornerRadius = 11
        
        tvLike.textColor = .black
        tvLike.text = "board_text_4".localized()
        tvLike.setFont(type: .regular, size: 10)
        btnLike.layer.opacity = 0.3
        btnLike.layer.cornerRadius = 11
        
        setButton(button: 0)
        
        /** 테이블 뷰 설정 */
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        tableView.separatorStyle = .none
        
        /** footer 설정 */
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 20))
        footerView.backgroundColor = .white
        tableView.tableFooterView = footerView
    }
    
    /** Rx 설정 */
    private func setRx() {
        
        /** 신규순 버튼 클릭 */
        btnNew.rx.tap.bind {
            self.setButton(button: 0)
        }.disposed(by: disposeBag)
        
        /** 조회순 버튼 클릭 */
        btnView.rx.tap.bind {
            self.setButton(button: 1)
        }.disposed(by: disposeBag)
        
        /** 좋아요 순 버튼 클릭 */
        btnLike.rx.tap.bind {
            self.setButton(button: 2)
        }.disposed(by: disposeBag)
        
        
        /** rx - 게시판 - 카테고리 */
        RxUtils.shared().selectCategoryObserver.subscribe(onNext: { category in
            
            self.setNavigationBar(label: self.tvNavigationTitle, title: category.rawValue)
        }).disposed(by: disposeBag)
    }
    
    /** 버튼 설정 */
    private func setButton(button: Int) {
        
        /** 신규순 */
        if button == 0 {
            btnNew.backgroundColor = BaseConstraint.COLOR_PRIMARY
            btnView.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
            btnLike.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
        }
        /** 조회순 */
        else if button == 1 {
            btnView.backgroundColor = BaseConstraint.COLOR_PRIMARY
            btnNew.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
            btnLike.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
        }
        /** 좋아요 순 */
        else {
            btnLike.backgroundColor = BaseConstraint.COLOR_PRIMARY
            btnNew.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
            btnView.backgroundColor = BaseConstraint.COLOR_LIGHTE_GRAY
        }
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
