import UIKit

extension UIEdgeInsets {
    init(paddingTop: CGFloat = .zero,
         paddingLeft: CGFloat = .zero,
         paddingBottom: CGFloat = .zero,
         paddingRight: CGFloat = .zero
    ) {
        self.init(top: paddingTop, left: paddingLeft, bottom: paddingBottom, right: paddingRight)
    }
    
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(horizontal: CGFloat = .zero, vertical: CGFloat = .zero) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
