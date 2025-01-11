import UIKit

final class Button: UIButton {
    private let defaultHeight: CGFloat = 45
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .medium)
        loading.color = .red
        return loading
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .red : .clear
        }
    }
    
    var text: String? {
        didSet {
            setTitle(text, for: [])
        }
    }

    init() {
        super.init(frame: .zero)
        setStyle()
        height(defaultHeight)
        addLoadingView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setStyle()
    }
    
    func startLoading() {
        text = ""
        loadingView.startAnimating()
    }
    
    func stopLoading() {
        loadingView.stopAnimating()
    }
}

private extension Button {
    func addLoadingView() {
        addSubview(loadingView)
        loadingView.fitToParent()
    }

    func setStyle() {
        border(color: .red, width: 1, opacity: 1, radius: Radius.medium)
        setTitleColor(.red, for: [])
        titleLabel?.font = Typography.highlightTertiaryTitle.font
    }
}
