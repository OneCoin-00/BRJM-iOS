import UIKit
import RxCocoa


/**
 - Note: Tab Bar 설정
 */
class TabBarViewController: BaseTabBarViewController {

    static var shared: TabBarViewController?
    fileprivate var customTabBar:CustomTabBar!
    
    @IBOutlet weak var homeTabBar: UITabBar!
    
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TabBarViewController.shared == nil {
            TabBarViewController.shared = self
        }
        
        
        /** 커스텀 탭바 설정 */
        customTabBar = CustomTabBar.getFromNib()
        customTabBar.initTab()
        customTabBar.frame = CGRect(x: 0, y: CommonUtils.shared().screenHeight-88, width: CommonUtils.shared().screenWidth, height: 88)
        view.addSubview(customTabBar)
        
        /** 홈 클릭 */
        customTabBar.setActionHomeTapped {
            self.setViews(0)
        }
        
        /** 게시판 클릭 */
        customTabBar.setActionBoardTapped {
            self.setViews(1)
        }
        
        /** 글쓰기 클릭 */
        customTabBar.setActionWriteTapped {
            self.setViews(2)
        }
        
        /** 환경 소식 클릭 */
        customTabBar.setActionNewsTapped {
            self.setViews(3)
        }
        
        /** 마이페이지 클릭 */
        customTabBar.setActionMyPageTapped {
            self.setViews(4)
        }
    }
    
    private func setViews(_ index: Int) {
        
        if self.selectedIndex == index { return }
        let _: Int = self.selectedIndex
        
        self.hapticImapact.impactOccurred()
        self.selectedIndex = index
        self.customTabBar.controlTab(index)
    }
}
