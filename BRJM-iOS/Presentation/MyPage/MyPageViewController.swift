import UIKit
import SwiftyUserDefaults
import RxCocoa
import RxSwift


/**
 - Note: 마이페이지
 */
class MyPageViewController: BaseViewController {

    /** 네비게이션 바 */
    @IBOutlet weak var tvNavigationTitle: UILabel!
    @IBOutlet weak var btnSetting: UIButton!
    
    /** 프로필 */
    @IBOutlet weak var ivProfile: UIImageView!
    @IBOutlet weak var tvNickname: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var btnUpdateProfile: UIButton!
    
    /** 버튼 */
    @IBOutlet weak var btnAlert: UIButton!
    @IBOutlet weak var btnPost: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    
    /** 하단 라인 */
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    
    /** 컨테이너 뷰 */
    @IBOutlet weak var containerView: UIView!
    private var pageViewController: UIPageViewController!
    private var pages = [UIViewController]()
    private var currentPage: Int? = 0
    private var beforePage: Int? = 0
    private var currentIndex: Int?
    private var pendingIndex: Int?
    private var page1: AlertView!
    private var page2: MyPostView!
    private var page3: MyLikedView!
    
    
    /** Lifecycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 뷰 설정 */
        setViews()
        setPageViews()
        setRx()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = UserDefaults.standard.data(forKey: BaseConstraint.APP_USER_PROFILE) {
            let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            ivProfile.image = image
        } else {
            ivProfile.image = UIImage(named: "icDefaultProfile")
        }
    }
    
    /** 뷰 설정 */
    private func setViews() {
        
        /** 네비게이션 바 설정 */
        setNavigationBar(label: tvNavigationTitle, title: "mypage_text_1".localized())
        
        
        /** 프로필 이미지 */
        ivProfile.layer.cornerRadius = ivProfile.width / 2
        
        /** 닉네임 */
        tvNickname.textColor = .black
        tvNickname.setFont(type: .bold, size: 20)
    
        /** 버튼 */
        btnAlert.isSelected = true
        btnPost.isSelected = false
        btnLike.isSelected = false
        
        /** 하단 라인 뷰 */
        bottomLineView.backgroundColor = BaseConstraint.COLOR_LIGHT_GRAY
        indicatorView.backgroundColor = BaseConstraint.COLOR_PRIMARY
    }
    
    /** 페이지 뷰 설정 */
    private func setPageViews() {
        
        let storyboard = UIStoryboard(name: "MyPageScreen", bundle: nil)
        
        page1 = (storyboard.instantiateViewController(withIdentifier: "AlertView") as! AlertView)
        page2 = (storyboard.instantiateViewController(withIdentifier: "MyPostView") as! MyPostView)
        page3 = (storyboard.instantiateViewController(withIdentifier: "MyLikedView") as! MyLikedView)
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.isPagingEnabled = true
        
        pageViewController.setViewControllers([page1], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        
        containerView.addSubview(pageViewController.view)
        setAutoLayout(from: pageViewController.view, to: containerView)
    }
    
    /** Rx 설정 */
    private func setRx() {
        
        /** 설정 버튼 클릭 */
        btnSetting.rx.tap.bind {
            
            self.moveToSetting()
        }.disposed(by: disposeBag)
        
        
        /** 탭 바 알림 버튼 클릭 */
        btnAlert.rx.tap.bind {
            self.beforePage = 0
            self.currentPage = 0
            self.controlPageView()
        }.disposed(by: disposeBag)
        
        /** 탭 바 내가 쓴 글 버튼 클릭 */
        btnPost.rx.tap.bind {
            self.currentPage = 1
            self.controlPageView()
        }.disposed(by: disposeBag)
        
        /** 탭 바 내가 좋아한 글 버튼 클릭 */
        btnLike.rx.tap.bind {
            self.beforePage = 2
            self.currentPage = 2
            self.controlPageView()
        }.disposed(by: disposeBag)
        
        
        /** 프로필 변경 버튼 클릭 */
        btnUpdateProfile.rx.tap.bind {
            
            self.moveToProfile()
        }.disposed(by: disposeBag)
    }
    
    /** 페이지 설정 */
    private func controlPageView() {
        
        /** 알림 */
        if currentPage == 0 {
            controlTabBarButton()
            indicatorAnimation(button: btnAlert)
            pageViewController.setViewControllers([self.page1], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
        }
        
        /** 내가 쓴 글 */
        else if currentPage == 1 {
            controlTabBarButton()
            indicatorAnimation(button: btnPost)
            
            if beforePage == 0 {
                pageViewController.setViewControllers([self.page2], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
            } else {
                pageViewController.setViewControllers([self.page2], direction: UIPageViewController.NavigationDirection.reverse, animated: true, completion: nil)
            }
        }
        
        /** 내가 좋아한 글 */
        else {
            controlTabBarButton()
            indicatorAnimation(button: btnLike)
            pageViewController.setViewControllers([self.page3], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
    }
    
    /** 탭 바 버튼 설정 */
    private func controlTabBarButton() {
        
        /** 알림 버튼 활성화 */
        if currentPage == 0 {
            btnAlert.isSelected = true
            btnPost.isSelected = false
            btnLike.isSelected = false
        }
        
        /** 내가 쓴 글 버튼 활성화 */
        else if currentPage == 1 {
            btnAlert.isSelected = false
            btnPost.isSelected = true
            btnLike.isSelected = false
        }
        
        /** 내가 좋아한 글 버튼 활성화 */
        else {
            btnAlert.isSelected = false
            btnPost.isSelected = false
            btnLike.isSelected = true
        }
    }
    
    /** 하단 인디케이터 설정 */
    private func indicatorAnimation(button: UIButton) {
        
        var transform = CGAffineTransform(translationX: 0, y: 0)
        var width = CGFloat(0)
        
        /** 알림 버튼 */
        if button == btnAlert {
            transform = CGAffineTransform(translationX: 0, y: 0)
            width = button.width
        }
        /** 내가 쓴 글 버튼 */
        else if button == btnPost {
            transform = CGAffineTransform(translationX: button.width, y: 0)
            width = button.width
        }
        /** 내가 좋아한 글 버튼 */
        else {
            transform = CGAffineTransform(translationX: button.width * 2, y: 0)
            width = button.width
        }
        
        UIView.animate(withDuration: 0.1, animations: {
            self.indicatorView.transform = transform
            self.indicatorView.frame.size.width = width
        }, completion: {(isCompleted) in
            
        })
    }
    
    /** 프로필 변경으로 이동 */
    private func moveToProfile() {
        
        if let nvc = self.navigationController {
            
            if !(nvc.topViewController?.description.contains("UpdateProfileViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "MyPageScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
                vc.modalTransitionStyle = .crossDissolve
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
    
    /** 설정으로 이동 */
    private func moveToSetting() {
        
        if let nvc = self.navigationController {
            
            if !(nvc.topViewController?.description.contains("SettingViewController"))! {
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "MyPageScreen", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
                vc.modalTransitionStyle = .crossDissolve
                
                nvc.pushViewController(vc, animated: true)
            }
        }
    }
}


extension MyPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        return (previousIndex == -1) ? nil : pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        return (nextIndex == pages.count) ? nil : pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        pendingIndex = pages.firstIndex(of:pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            currentIndex = pendingIndex
            currentPage = currentIndex
            
            if currentIndex! == 0 {
                controlTabBarButton()
                indicatorAnimation(button: btnAlert)
                beforePage = currentPage
            } else if currentIndex! == 1 {
                controlTabBarButton()
                indicatorAnimation(button: btnPost)
            } else {
                controlTabBarButton()
                indicatorAnimation(button: btnLike)
                beforePage = currentPage
            }
        }
    }
}
