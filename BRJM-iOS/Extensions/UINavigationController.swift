import UIKit


extension UINavigationController {

    var rootViewController: UIViewController? {
        return viewControllers.first
    }
}
