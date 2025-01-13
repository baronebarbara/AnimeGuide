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
}
