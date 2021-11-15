import UIKit

class SchoolDetailView: UIView {

    // MARK: - Objects
    lazy var tableView: UITableView = {
        let style = UITableView.Style.insetGrouped
        let tableView = UITableView(frame: frame, style: style)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(PlainTextCell.self, forCellReuseIdentifier: "plainTextCell")
        tableView.register(LoaderCell.self, forCellReuseIdentifier: "loaderCell")
        tableView.register(MapCell.self, forCellReuseIdentifier: "mapCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1)
        setupViews()
    }

    private func setupViews() {
        setupTableView()
    }

    // MARK: - Constraints
    private func setupTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
