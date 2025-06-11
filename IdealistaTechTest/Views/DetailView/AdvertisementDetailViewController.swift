import UIKit
import SwiftUI
import MapKit

class AdvertisementDetailViewController: UIViewController {
    init(viewModel: AdvertisementDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Detail"
        
        setupScrollView()
        fetchData()
    }
    
    // MARK: - Private properties
    private let viewModel: AdvertisementDetailViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9).isActive = true
        return imageView
    }()
    
    private lazy var carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        collectionView.register(ImageCarouselCell.self, forCellWithReuseIdentifier: ImageCarouselCell.reuseIdentifier)
        collectionView.dataSource = self
        return collectionView
    }()

    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.alignment = .top
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.heightAnchor.constraint(equalToConstant: 250).isActive = true
        map.layer.cornerRadius = 8
        map.clipsToBounds = true
        return map
    }()

    
    // MARK: - Private methods
    private func fetchData() {
        Task {
            await viewModel.getAdvertisementDetail()
            DispatchQueue.main.async {
                self.setupLayout()
                self.populateData()
            }
        }
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func setupLayout() {
        guard let advertisement = viewModel.advertisement else {
            return
        }
        
        stackView.addArrangedSubview(carouselCollectionView)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(infoStack)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(mapView)
        
        setupMapLocation()

        let leftStack = UIStackView(arrangedSubviews: [
            makeInfoLabel(text: advertisement.roomsText),
            makeInfoLabel(text: advertisement.bathroomsText),
            makeInfoLabel(text: advertisement.sizeText)
        ])
        leftStack.axis = .vertical
        leftStack.spacing = 4
        leftStack.alignment = .leading
        leftStack.translatesAutoresizingMaskIntoConstraints = false

        let rightStack = UIStackView(arrangedSubviews: [
            makeInfoLabel(text: advertisement.parkingText),
            makeInfoLabel(text: advertisement.acText)
        ])
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.alignment = .leading
        rightStack.translatesAutoresizingMaskIntoConstraints = false

        infoStack.addArrangedSubview(leftStack)
        infoStack.addArrangedSubview(rightStack)
    }
    
    private func makeInfoLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = text
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }
    
    private func populateData() {
        guard let advertisement = viewModel.advertisement else {
            return
        }
        
        priceLabel.text = advertisement.formattedPrice
        addressLabel.text = advertisement.title
        descriptionLabel.text = advertisement.description
        carouselCollectionView.reloadData()
    }
    
    private func setupMapLocation() {
        guard let advertisement = viewModel.advertisement else { return }

        let coordinate = CLLocationCoordinate2D(latitude: advertisement.latitude, longitude: advertisement.longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = advertisement.title
        mapView.addAnnotation(annotation)
    }

}

extension AdvertisementDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.advertisement?.imageUrls.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCarouselCell.reuseIdentifier, for: indexPath) as? ImageCarouselCell,
              let imageUrl = viewModel.advertisement?.imageUrls[indexPath.item] else {
            return UICollectionViewCell()
        }
        cell.configure(with: imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let imageUrl = viewModel.advertisement?.imageUrls[indexPath.item] else { return }
        let zoomView = ImageZoomView(imageUrl: URL(string: imageUrl)!)
        let hostingController = UIHostingController(rootView: zoomView)
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: true, completion: nil)
    }
}

extension AdvertisementDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.8
        return CGSize(width: width, height: 200)
    }
}

