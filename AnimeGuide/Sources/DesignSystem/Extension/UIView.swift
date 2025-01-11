import UIKit

extension UIView {
    func border(
        color: UIColor? = nil,
        width: CGFloat = 0,
        opacity: CGFloat = 1,
        radius: CGFloat = 0
    ) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = width
        layer.borderColor = color?.withAlphaComponent(opacity).cgColor
        clipsToBounds = false
    }
    
    func shadow(
        color: UIColor,
        opacity: Float,
        offset: CGSize,
        radius: CGFloat
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            addSubview(view)
        }
    }
    
    func animate(_ animations: @escaping (() -> Void)) {
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve) {
            animations()
        }
    }
    
    func shrink(completion: @escaping ((Bool) -> Void)) {
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.2,  animations: { [unowned self] in
                self.transform = .identity
            }, completion: completion)
        })
    }
}
