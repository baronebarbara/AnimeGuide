import class UIKit.UITableViewCell

extension UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
