import UIKit

class AdvertisementCell: UITableViewCell {
    static let reuseIdentifier = "AdvertisementCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)

        setupLayout()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var onFavoriteTapped: (() -> Void)?

    @objc private func favoriteButtonTapped() {
        onFavoriteTapped?()
    }

    // MARK: - Private properties
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let labelView = UILabel()
        labelView.font = .systemFont(ofSize: 16, weight: .semibold)
        labelView.numberOfLines = 2
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    private let priceLabel: UILabel = {
        let labelView = UILabel()
        labelView.font = .systemFont(ofSize: 14, weight: .bold)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()

    private let detailsLabel: UILabel = {
        let labelView = UILabel()
        labelView.font = .systemFont(ofSize: 12, weight: .regular)
        labelView.textColor = .darkGray
        labelView.numberOfLines = 1
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteSinceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    // MARK: - Private methods
    private func setupLayout() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(favoriteSinceLabel)
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor, multiplier: 9/16),

            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: favoriteSinceLabel.leadingAnchor, constant: -8),
            
            favoriteSinceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteSinceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            detailsLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
        
    func configure(with model: AdvertisementModel) {
        titleLabel.text = model.title
        priceLabel.text = model.formattedPrice
        detailsLabel.text = [model.roomsText, model.bathroomsText, model.sizeText].joined(separator: " · ")
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let heartImageName = model.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartImageName, withConfiguration: config), for: .normal)
        
        if let url = URL(string: model.thumbnailUrl) {
            URLSession.shared.dataTask(with: url) { data,_,_ in
                guard let d = data, let img = UIImage(data: d) else { return }
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = img
                }
            }.resume()
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        
        if model.isFavorite, let date = model.favoriteDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .short // o .medium / .long según prefieras
            formatter.timeStyle = .none
            let dateString = formatter.string(from: date)
            favoriteSinceLabel.text = "Favorite since \(dateString)"
            favoriteSinceLabel.isHidden = false
        } else {
            favoriteSinceLabel.isHidden = true
        }
    }
}
