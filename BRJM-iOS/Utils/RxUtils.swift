import Foundation
import SwiftyUserDefaults
import SwiftyJSON
import RxSwift
import RxCocoa


/**
 - Global Rx 유틸리티
 */
class RxUtils {
    
    private static var _shared: RxUtils = {
        
        let obj = RxUtils(/*parameta*/)
        // Configuration
        
        return obj
    }()
    
    private init(/*parameta*/) {
    }
    
    class func shared() -> RxUtils {
        return _shared
    }
    
    /** Rx DisposeBag */
    public var disposeBag = DisposeBag()
    
    
    /** 홈 - 탭 이동 */
    public let selectTabBarObservable = PublishSubject<Enum.TabBarType>()/** Observable */
    public var selectTabBarObserver:Observable<Enum.TabBarType> {
        return selectTabBarObservable.asObservable()
    }
    
    /** 게시판 - 카테고리 */
    public let selectCategoryObservable = PublishSubject<Enum.Category>()/** Observable */
    public var selectCategoryObserver:Observable<Enum.Category> {
        return selectCategoryObservable.asObservable()
    }
}
