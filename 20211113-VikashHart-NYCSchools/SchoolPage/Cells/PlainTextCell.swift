import UIKit

class PlainTextCell: UITableViewCell {

    //MARK: - Objects
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "plainTextCell")
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    //MARK: - Set up methods
    private func commonInit() {
        backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func setLabelText(text: String) {
        label.text = text
    }

    private func setupViews() {
        setupLabel()
    }

    //MARK: - Constraints
    private func setupLabel() {
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
