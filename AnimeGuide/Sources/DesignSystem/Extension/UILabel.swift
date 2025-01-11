import UIKit

extension UILabel {
    static func build(type: Typography, color: UIColor, text: String? = nil, numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = type.font
        label.textColor = color
        label.text = text
        label.numberOfLines = numberOfLines
        return label
    }
}
