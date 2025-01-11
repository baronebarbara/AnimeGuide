import UIKit

enum Typography {
    /// Bold 34
    case largeTitle
    /// Bold 22
    case highlightTitle
    /// Bold 18
    case highlightSecondaryTitle
    /// Bold 14
    case highlightTertiaryTitle
    /// Regular 18
    case title
    /// Regular 16
    case subtitle
    /// Regular 14
    case caption

    var font: UIFont? {
        let font: UIFont?
        switch self {
        case .largeTitle:
            font = UIFont.systemFont(ofSize: 34, weight: .bold)
        case .highlightTitle:
            font = UIFont.systemFont(ofSize: 22, weight: .bold)
        case .highlightSecondaryTitle:
            font = UIFont.systemFont(ofSize: 18, weight: .bold)
        case .highlightTertiaryTitle:
            font = UIFont.systemFont(ofSize: 14, weight: .bold)
        case .title:
            font = UIFont.systemFont(ofSize: 18, weight: .regular)
        case .subtitle:
            font = UIFont.systemFont(ofSize: 16, weight: .regular)
        case .caption:
            font = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
        return font
    }
}
