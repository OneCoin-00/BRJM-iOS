import UIKit


/**
 - Note: 재사용 셀
 */
internal extension UICollectionView {

    
    /// - Parameter _: UICollectionViewCell to register for reuse.
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func registerSupplementaryView<T: UICollectionReusableView>(_ : T.Type, kind: String) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    /// - Parameter indexPath: indexPath to dequeue cell for
    /// - Returns: a reused UICollectionViewCell associated with the indexPath
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(kind: String, indexPath: IndexPath) -> T? where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T
    }
    
    
    // #
    func setItemsInRow(items: Int) {
        
        if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            let contentInset = self.contentInset
            let itemsInRow: CGFloat = CGFloat(items);
            let innerSpace = layout.minimumInteritemSpacing * (itemsInRow - 1.0)
            let insetSpace = contentInset.left + contentInset.right + layout.sectionInset.left + layout.sectionInset.right
            let width = floor((frame.width - insetSpace - innerSpace) / itemsInRow);
            layout.itemSize = CGSize(width: width, height: width)
        }
    }
}
