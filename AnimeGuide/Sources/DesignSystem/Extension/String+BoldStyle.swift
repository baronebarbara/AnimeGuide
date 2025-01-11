import Foundation
import UIKit

extension String {
    func withBoldText(text: String, regularFont: UIFont?, boldFont: UIFont?) -> NSAttributedString? {
        guard let regularFont = regularFont, let boldFont = boldFont else { return nil }
        let fullString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: regularFont])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: boldFont]
        let range = (self as NSString).range(of: text)
        fullString.addAttributes(boldFontAttribute, range: range)
        return fullString
    }
}
