import UIKit
import MaterialDesignWidgets

/**
 - Note: 버튼 클릭 애니메이션
 */
class BaseButton: MaterialButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    func setupView() {
        rippleLayerColor = BaseConstraint.COLOR_BALCK_WITH_ALPHA1
        rippleLayerAlpha = BaseConstraint.RIPPLE_LAYER_ALPHA
        clipsToBounds = true
    }
    
    public func getText() -> String {
        return titleLabel?.text ?? ""
    }
}
