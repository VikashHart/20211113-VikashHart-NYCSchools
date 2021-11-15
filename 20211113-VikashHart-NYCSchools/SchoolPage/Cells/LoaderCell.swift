import UIKit

class LoaderCell: UITableViewCell {

    //MARK: - Objects
    lazy var activitySpinner: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "loaderCell")
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

    private func setupViews() {
        setupSpinner()
    }

    //MARK: - Constraints
    private func setupSpinner() {
        contentView.addSubview(activitySpinner)
        NSLayoutConstraint.activate([
            activitySpinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            activitySpinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            activitySpinner.heightAnchor.constraint(equalToConstant: 60),
            activitySpinner.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
