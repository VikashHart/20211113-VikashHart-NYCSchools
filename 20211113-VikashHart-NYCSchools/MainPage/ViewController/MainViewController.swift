import UIKit

class MainViewController: UIViewController {

    private var viewModel: MainPageVCViewModeling = MainPageVCViewModel()
    private lazy var mainView: MainPageView = {
        let view = MainPageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    private func bindViewModel() {
        viewModel.onDataRecieved = { [weak self] in
            self?.mainView.activitySpinner.stopAnimating()
            self?.mainView.collectionView.reloadData()
        }
    }

    @objc private func navigateBack() {
        //create modes for boro and schools to determine which cell to use and reload data
        viewModel.setUIMode(mode: .Boro)
        viewModel.resetSchools()
        self.mainView.showBackButton(bool: false)
        self.mainView.collectionView.reloadData()
    }

    private func configureView() {
        self.view.backgroundColor = .white
        constrainView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        bindViewModel()
        mainView.backButton.addTarget(self,
                                      action: #selector(navigateBack),
                                      for: .touchUpInside)
    }

    private func constrainView() {
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch viewModel.uiMode {
        case .Boro:
            let cell = self.mainView.collectionView.cellForItem(at: indexPath) as! BoroCell
            self.viewModel.setBoro(boro: cell.viewModel.boroCode)
            self.viewModel.setUIMode(mode: .School)
            self.viewModel.getSchools(with: cell.viewModel.boroCode)
            self.mainView.activitySpinner.startAnimating()
            self.mainView.showBackButton(bool: true)
            self.mainView.collectionView.reloadData()
        case .School:
            let detailVC = SchoolDetailViewController(school: viewModel.schools[indexPath.row])
            self.present(detailVC, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.schools.count - 2 {
            if let boro = viewModel.selectedBoro {
                viewModel.getNextSchools(with: boro, offset: viewModel.schools.count)
                print("infinite scrolling")
            }
        }
    }
}

//MARK: - CollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.uiMode {
        case .Boro:
            return viewModel.boros.count
        case .School:
            return viewModel.schools.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.uiMode {
        case .Boro:
            guard let cell = mainView.collectionView.dequeueReusableCell(
                withReuseIdentifier: "boroCell",
                for: indexPath) as? BoroCell else
            { return UICollectionViewCell() }
            let viewModel = self.viewModel.getBoroCellViewModel(indexPath: indexPath)
            cell.setViewModel(viewModel: viewModel)
            return cell
        case .School:
            guard let cell = mainView.collectionView.dequeueReusableCell(
                withReuseIdentifier: "schoolCell",
                for: indexPath) as? SchoolCell else
            { return UICollectionViewCell() }
            let viewModel = self.viewModel.getSchoolCellViewModel(indexPath: indexPath)
            cell.setViewModel(viewModel: viewModel)
            cell.addDropShadow()
            return cell
        }
    }
}

//MARK: - Collectionview flow layout
extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let screenWidth = UIScreen.main.bounds.width
            let width = (screenWidth - (self.viewModel.cellSpacing * self.viewModel.numberOfSpaces))
            let height = width / 2

            return CGSize(width: width , height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.viewModel.cellSpacing, left: self.viewModel.cellSpacing, bottom: self.viewModel.cellSpacing, right: self.viewModel.cellSpacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.viewModel.cellSpacing
    }
}
