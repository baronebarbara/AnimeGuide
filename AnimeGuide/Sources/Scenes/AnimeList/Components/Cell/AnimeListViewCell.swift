import UIKit

extension AnimeListViewCell.Constants {
    enum Insets {
        static let cell = UIEdgeInsets(vertical: Spacing.space1)
    }
    
    enum Size {
        static let image: CGFloat = 120
        static let status: CGFloat = 12
    }
    
    enum Opacity {
        static let border: CGFloat = 0.25
        static let shadow: Float = 0.1
    }
}

final class AnimeListViewCell: UITableViewCell {
    fileprivate enum Constants { }
    
    private lazy var animeImage: UIImageView = {
        let image = UIImageView()
        image.border(radius: Radius.medium)
        image.image = UIImage(systemName: "photo")
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return image
    }()
    
    private lazy var nameLabel = UILabel.build(type: .highlightSecondaryTitle, color: .systemGray4, numberOfLines: 1)
    
    private lazy var genresLabel = UILabel.build(type: .caption, color: .systemGray3)
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, genresLabel])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space1
        return stackView
    }()
    
    private lazy var yearLabel = UILabel.build(type: .caption, color: .systemGray3)
    
    private lazy var scoreImage: UIImageView = {
        let image = UIImageView()
        image.border(radius: Radius.medium)
        image.image = UIImage(named: "star")
        return image
    }()
    
    private lazy var scoreLabel = UILabel.build(type: .caption, color: .systemGray3)
    
    private lazy var scoreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [scoreImage, scoreLabel])
        stackView.axis = .horizontal
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var yearAndScoreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearLabel, scoreStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space0
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topStackView, yearAndScoreStackView])
        stackView.axis = .vertical
        stackView.spacing = Spacing.space3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(inset: Spacing.space2)
        return stackView
    }()
    
    private lazy var rootStackView: UIStackView = UIStackView(arrangedSubviews: [animeImage, labelsStackView])
    
    private lazy var cellContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    func setup(with viewModel: AnimeListViewCellViewModel) {
        animeImage.loadImage(from: viewModel.imageUrl, placeholder: UIImage(systemName: "photo"))
        nameLabel.text = viewModel.name
        genresLabel.text = viewModel.genres.joined(separator: ",")
        yearLabel.text = viewModel.year
        scoreLabel.text = viewModel.score
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
        setupStyles()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        animeImage.image = UIImage(systemName: "photo")
    }
}

extension AnimeListViewCell: ViewConfiguration {
    func setupConstraints() {
        cellContainer.fitToParent(with: Constants.Insets.cell)
        rootStackView.fitToParent()
    }
    
    func setupHierarchy() {
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(rootStackView)
        animeImage.size(Constants.Size.image)
        scoreImage.size(Constants.Size.status)
    }
    
    func setupStyles() {
        let shadowOffset = CGSize(width: 0, height: 3)
        cellContainer.border(color: .blue,
                             width: 1,
                             opacity: Constants.Opacity.border,
                             radius: Radius.medium)
        
        cellContainer.shadow(color: .blue,
                             opacity: Constants.Opacity.shadow,
                             offset: shadowOffset,
                             radius: 5)
        
        backgroundColor = .gray
        selectionStyle = .none
        nameLabel.adjustsFontSizeToFitWidth = true
    }
}
