import UIKit

/**
 - note: Tab Bar 설정
 */
class CustomTabBar: UIView {

    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnBoard: UIButton!
    @IBOutlet weak var btnWrite: UIButton!
    @IBOutlet weak var btnNews: UIButton!
    @IBOutlet weak var btnMyPage: UIButton!
    
    private var actionTappedHome: ()->() = {}
    private var actionTappedBoard: ()->() = {}
    private var actionTappedWrite: ()->() = {}
    private var actionTappedNews: ()->() = {}
    private var actionTappedMyPage: ()->() = {}
    
    
    static func getFromNib() -> CustomTabBar {
        let tabBarView = UINib.init(nibName: "CustomTabBar", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomTabBar
        
        return tabBarView
    }
    
    /** 초기화 */
    public func initTab() {
        
        /** 라인 설정 */
        lineView.backgroundColor = BaseConstraint.COLOR_LIGHT_GRAY
        
        /** 탭바 설정 */
        controlTab(0)
    }
    
    /** 탭바 설정 */
    public func controlTab(_ index: Int) {
        
        btnHome.isSelected = false
        btnBoard.isSelected = false
        btnWrite.isSelected = false
        btnNews.isSelected = false
        btnMyPage.isSelected = false
        
        switch index {
        case 0:
            btnHome.isSelected = true
        case 1:
            btnBoard.isSelected = true
        case 2:
            btnWrite.isSelected = true
        case 3:
            btnNews.isSelected = true
        case 4:
            btnMyPage.isSelected = true
        default :
            break
        }
    }
    
    @IBAction func homeTapped(_ sender: UIButton) {
        controlTab(0)
        actionTappedHome()
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
        controlTab(1)
        actionTappedBoard()
    }
    
    @IBAction func waitTapped(_ sender: UIButton) {
        actionTappedWrite()
    }
    
    @IBAction func achievementsTapped(_ sender: UIButton) {
        controlTab(2)
        actionTappedNews()
    }
    
    @IBAction func myTapped(_ sender: UIButton) {
        controlTab(3)
        actionTappedMyPage()
    }
    
    public func setActionHomeTapped(action:@escaping ()->()) {
        actionTappedHome = action
    }
    public func setActionBoardTapped(action:@escaping ()->()) {
        actionTappedBoard = action
    }
    public func setActionWriteTapped(action:@escaping ()->()) {
        actionTappedWrite = action
    }
    public func setActionNewsTapped(action:@escaping ()->()) {
        actionTappedNews = action
    }
    public func setActionMyPageTapped(action:@escaping ()->()) {
        actionTappedMyPage = action
    }
}
