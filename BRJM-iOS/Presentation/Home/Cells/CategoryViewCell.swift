import UIKit


/**
 - note: Category View Cell 설정
 */
class CategoryViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView!
    
    /** 프로퍼티 */
    private var categoryList: [HomeModel.Category] = []/** 카테고리 리스트 */
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lineView.backgroundColor = BaseConstraint.COLOR_LIGHT_GRAY
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerReusableCell(CategoryCell.self)
        
        setCategory()
    }
    
    /** 카테고리 설정 */
    private func setCategory() {
        
        for i in 1...8 {
            let data = HomeModel.Category()
            data.title = "icCategory\(i)"
            data.isSelected = true
            
            categoryList.append(data)
        }
    }
}


extension CategoryViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        let data = categoryList[index]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.ID, for: indexPath) as! CategoryCell
        
        cell.setCells(data, index: index + 1)
        
        cell.btnCategory.tag = index
        cell.btnCategory.addTarget(self, action: #selector(selectedCategory(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    /** 셀 사이즈 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: (collectionView.height - 12) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    /** 셀 줄 간격 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    /** 셀 간격 */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ((collectionView.width - 40) / 4) / 3
    }
    
    /** 카테고리 선택 */
    @objc private func selectedCategory(_ sender: UIButton) {
        
        let index = sender.tag
        let category: Enum.Category
        
        if index == 0 {
            category = .life
        } else if index == 1 {
            category = .energy
        } else if index == 2 {
            category = .diy
        } else if index == 3 {
            category = .dress
        } else if index == 4 {
            category = .furniture
        } else if index == 5 {
            category = .plant
        } else if index == 6 {
            category = .prop
        } else {
            category = .beauty
        }
        
        /** rx - 게시판 - 카테고리 */
        RxUtils.shared().selectCategoryObservable.onNext(category)
        
        /** rx - 홈 - 탭바 */
        RxUtils.shared().selectTabBarObservable.onNext(.board)
    }
}
