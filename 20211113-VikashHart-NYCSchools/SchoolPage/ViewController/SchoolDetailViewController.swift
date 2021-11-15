import UIKit

class SchoolDetailViewController: UIViewController {

    private var viewModel: SchoolDetailModeling
    private var detailView: SchoolDetailView = {
        let view = SchoolDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    init(school: SchoolData) {
        self.viewModel = SchoolDetailViewModel(school: school)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindViewModel() {
        self.viewModel.onSectionDataUpdated = { [weak self] in
            self?.detailView.tableView.reloadData()
        }
    }

    private func configureView() {
        self.view.backgroundColor = .white
        constrainView()
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        bindViewModel()
    }

    private func constrainView() {
        view.addSubview(detailView)
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SchoolDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension SchoolDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionData[section]?.content.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let content = viewModel.sectionData[indexPath.section]?.content[indexPath.row] else { return UITableViewCell() }
        switch content.kind {
        case .plainText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plainTextCell", for: indexPath) as! PlainTextCell
            //in order to have multiple content types in the same content array we have to refer to them
            //by their shared base protocol. The tradeoff is that we lose the type information and have to
            //cast it back when we need it.
            cell.setLabelText(text: (content as! PlainTextContent).text)
            return cell
        case .loader:
            let cell = tableView.dequeueReusableCell(withIdentifier: "loaderCell", for: indexPath) as! LoaderCell
            cell.activitySpinner.startAnimating()
            return cell
        case .map:
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! MapCell
            let mapContent = content as! MapContent
            cell.setCoordinates(lat: mapContent.lat, long: mapContent.long)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionData[section]?.headerTitle
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sectionData.count
    }
}
