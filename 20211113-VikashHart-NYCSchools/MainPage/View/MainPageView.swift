import UIKit

class MainPageView: UIView {

    // MARK: - Objects
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "NYC High Schools"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("< Back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 20)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let boroCell = "boroCell"
    let schoolCell = "schoolCell"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(BoroCell.self, forCellWithReuseIdentifier: boroCell)
        collectionView.register(SchoolCell.self, forCellWithReuseIdentifier: schoolCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var activitySpinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    // MARK: - Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    // MARK: - Setup Methods
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }

    func showBackButton(bool: Bool) {
        switch bool {
        case true:
            backButton.isHidden = false
            headerTitle.isHidden = true
        case false:
            backButton.isHidden = true
            headerTitle.isHidden = false
        }
    }

    func activateSpinner(bool: Bool) {
        switch bool {
        case true:
            activitySpinner.isHidden = false
            activitySpinner.startAnimating()
        case false:
            activitySpinner.isHidden = true
            activitySpinner.stopAnimating()
        }
    }

    private func setupViews() {
        setupHeaderView()
        setupHeaderTitle()
        setupBackButton()
        setupCollectionView()
        setupActivitySpinner()
    }

    // MARK: - Constraints
    private func setupHeaderView() {
        addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupHeaderTitle() {
        headerView.addSubview(headerTitle)
        NSLayoutConstraint.activate([
            headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            headerTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            headerTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupBackButton() {
        headerView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupCollectionView() {
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupActivitySpinner() {
        addSubview(activitySpinner)
        NSLayoutConstraint.activate([
            activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            activitySpinner.heightAnchor.constraint(equalToConstant: 60),
            activitySpinner.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
