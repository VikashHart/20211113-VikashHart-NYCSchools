import UIKit

class BoroCell: UICollectionViewCell {
    var viewModel: BoroCellModeling = BoroCellViewModel(boro: BoroData(boroName: "",
                                                                       boroImage: UIImage(),
                                                                       boroCode: EndpointBuilder.Boro.queens))

    //MARK: - Objects
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.opacity = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var boroLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont(name: "AvenirNext-Bold", size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    //MARK: - Set up methods
    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setViewModel(viewModel: BoroCellModeling) {
        self.viewModel = viewModel
        updateUI()
    }

    private func updateUI() {
        imageView.image = viewModel.image
        boroLabel.text = viewModel.boroTitle
    }

    private func setupViews() {
        setupImageView()
        setupShadowView()
        setupBoroLabel()
    }

    //MARK: - Constraints
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupShadowView() {
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupBoroLabel() {
        addSubview(boroLabel)
        NSLayoutConstraint.activate([
            boroLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            boroLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            boroLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            boroLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
}
