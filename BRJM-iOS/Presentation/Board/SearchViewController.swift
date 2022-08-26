import UIKit
import RxCocoa
import RxSwift


/**
 - Note: 검색
 */
class SearchViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvSearch: TextFieldWithDelete!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    /** 최근 검색어 */
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var btnDeleteAll: UIButton!
    @IBOutlet weak var historyTableView: UITableView!
    
    /** 검색어 없음 */
    @IBOutlet weak var noneView: UIView!
    @IBOutlet weak var tvNone: UILabel!
    
    /** 하단 배경 뷰 */
    @IBOutlet weak var bacrgroundView: UIView!
    
    /** 검색 */
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    /** 프로퍼티 */
    private var historyList: [BoardModel.History] = []/** 최근 검색어 리스트*/
    private var searchList:[BoardModel.Post] = []/** 게시글 리스트 */
    
    /** life cycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 뷰 설정 */
        setViews()
        setTableView()
        setRx()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchView.isHidden = true
        historyView.isHidden = false
        
        noneView.isHidden = historyList.count != 0
        btnDeleteAll.isHidden = historyList.count == 0
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 검색어 텍스트 필드 */
        tvSearch.delegate = self
        tvSearch.becomeFirstResponder()
        tvSearch.setFont(.regular)
        tvSearch.returnKeyType = .search
        tvSearch.setPlaceholder(.regular, text: "search_text_1".localized())
        
        
        /** 타이틀 */
        tvTitle.text = "search_text_2".localized()
        tvTitle.textColor = .black
        tvTitle.setFont(type: .regular, size: 14)
        
        /** 전체 삭제 버튼 */
        btnDeleteAll.setTitle("search_text_3".localized())
        btnDeleteAll.setTitleColor(.black)
        btnDeleteAll.setFont(type: .regular, size: 14)
        
        /** 검색어 없음 타이틀 */
        tvNone.text = "search_text_4".localized()
        tvNone.textColor = BaseConstraint.COLOR_GRAY
        tvNone.setFont(type: .regular, size: 16)
        
        /** 하단 배경 뷰 */
        bacrgroundView.backgroundColor = BaseConstraint.COLOR_LIGHT_GRAY
    }
    
    /** 테이블 뷰 설정 */
    private func setTableView() {
        
        /** 최근 검색어 테이블 뷰 설정 */
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.register(UINib(nibName: "HistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "HistoryTableViewCell")
        historyTableView.separatorStyle = .none
        
        /** 검색 테이블 뷰 설정 */
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
        searchTableView.separatorStyle = .none
    }
    
    /** Rx설정 */
    private func setRx() {
        
        /** 뒤로가기 버튼 클릭 */
        btnBack.rx.tap.bind {
            
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        /** 검색 버튼 클릭 */
        btnSearch.rx.tap.bind {
            
            self.search()
        }.disposed(by: disposeBag)
        
        
        /** 텍스트 필드 입력 */
        tvSearch.rx.controlEvent([.editingChanged]).subscribe(onNext: {
            
            if self.tvSearch.text!.count == 0 {
                
                self.historyView.isHidden = false
                self.searchView.isHidden = true
                
                self.historyTableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
        /** 텍스트 필드 삭제 버튼 클릭 */
        tvSearch.deleteTapped = {
            
            self.historyView.isHidden = false
            self.searchView.isHidden = true
            
            self.historyTableView.reloadData()
        }
        
        
        /** 최근 검색어 삭제 - 전체 */
        btnDeleteAll.rx.tap.bind {
            
            self.historyList.removeAll()
            self.historyTableView.reloadData()
            
            self.noneView.isHidden = self.historyList.count != 0
            self.btnDeleteAll.isHidden = self.historyList.count == 0
        }.disposed(by: disposeBag)
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
            
            searchList.append(data)
        }
    }
    
    /** 검색 */
    private func search() {
        
        /** 검색어 있음 */
        if tvSearch.text!.count != 0 {
            
            /** 최근 검색어 리스트에 추가 */
            updateHistory()
            
            /** 검색 api 호출*/
            
            view.endEditing(true)
            
            historyView.isHidden = true
            searchView.isHidden = false
            
            searchTableView.reloadData()
        }
        
        /** 검색어 없음 */
        else {
            self.showToast(message: "".localized(), withDuration: 2, isTop: true)
        }
    }
    
    /** 최근 검색 리스트에 추가 */
    private func updateHistory() {
        
        let data = BoardModel.History()
        data.userSeq = "0"
        data.searchText = tvSearch.text!
        
        if historyList.count != 0 {
            for i in 0..<historyList.count {
                if historyList[i].searchText == data.searchText {
                    historyList.remove(at: i)
                    break
                }
            }
        }
        
        historyList.insert(data, at: 0)
        
        noneView.isHidden = historyList.count != 0
        btnDeleteAll.isHidden = historyList.count == 0
        
        historyTableView.reloadData()
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        /** 최근 검색기록 */
        case historyTableView:
            return historyList.count
            
        /** 검색 */
        case searchTableView:
            return searchList.count
            
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case historyTableView:
            
            let index = indexPath.row
            let data = historyList[index]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath as IndexPath) as! HistoryTableViewCell
            
            cell.setUpCell(data: data)
            
            cell.btnDelete.tag = index
            cell.btnDelete.addTarget(self, action: #selector(deleteHistory(_:)), for: .touchUpInside)
            
            cell.btnReSearch.tag = index
            cell.btnReSearch.addTarget(self, action: #selector(reSearch(_:)), for: .touchUpInside)
            
            cell.selectionStyle = .none
            
            return cell
        
        case searchTableView:
            
            let index = indexPath.row
            let data = searchList[index]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath as IndexPath) as! ListViewCell
            
            cell.setUpCell(data: data)
            
            cell.btnLike.tag = index
            cell.btnLike.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
            
            cell.btnDetail.tag = index
            cell.btnDetail.addTarget(self, action: #selector(detailTapped(_:)), for: .touchUpInside)
            
            cell.selectionStyle = .none
            
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    /** 최근 검색어 삭제 - 단일 */
    @objc private func deleteHistory(_ sender: UIButton) {
        
        let index = sender.tag
        
        historyList.remove(at: index)
        historyTableView.reloadData()
    }
    
    /** 최근 검색어로 재검색 */
    @objc private func reSearch(_ sender: UIButton) {
        
        let index = sender.tag
        let data = historyList[index]
        
        self.tvSearch.text = data.searchText
        self.tvSearch.btnDelete.isHidden = false
        
        self.search()
    }
    
    
    /** 좋아요 탭 */
    @objc private func likeTapped(_ sender: UIButton) {
        
        let index = sender.tag
        let data = searchList[index]
        let likeValue = data.isLiked
        
        data.isLiked = !likeValue
        searchList[index].isLiked = data.isLiked
        
        searchTableView.reloadData()
    }
    
    /** 상세보기 탭 */
    @objc private func detailTapped(_ sender: UIButton) {
        
        let index = sender.tag
        let data = searchList[index]
        
        /** 상세보기로 이동 */
    }
}


extension SearchViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.tvSearch {
            
            let text = self.tvSearch.text ?? ""
            if "" == text { return false }
            
            self.search()
        }
        
        return true
    }
}
