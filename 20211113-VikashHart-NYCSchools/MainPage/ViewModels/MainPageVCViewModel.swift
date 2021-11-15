import UIKit

protocol MainPageVCViewModeling {
    var cellSpacing: CGFloat { get }
    var numberOfSpaces: CGFloat { get }
    var numberOfCells: CGFloat { get }

    var uiMode: CollectionViewMode { get }
    var boros: [BoroData] { get }
    var schools: [SchoolData] { get }
    var selectedBoro: EndpointBuilder.Boro? { get }

    var onDataRecieved: (() -> Void)? { get set }

    func getBoroCellViewModel(indexPath: IndexPath) -> BoroCellModeling
    func getSchoolCellViewModel(indexPath: IndexPath) -> SchoolCellModeling
    func setUIMode(mode: CollectionViewMode)
    func setBoro(boro: EndpointBuilder.Boro)
    func getSchools(with boro: EndpointBuilder.Boro)
    func getNextSchools(with boro: EndpointBuilder.Boro, offset: Int)
    func resetSchools()
}

enum CollectionViewMode {
    case Boro
    case School
}

class MainPageVCViewModel: MainPageVCViewModeling {
    var cellSpacing: CGFloat
    var numberOfSpaces: CGFloat
    var numberOfCells: CGFloat

    private(set) var uiMode: CollectionViewMode

    let boros: [BoroData]
    private(set) var schools: [SchoolData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.onDataRecieved?()
            }
        }
    }

    private(set) var selectedBoro: EndpointBuilder.Boro?
    private let client: DataRetrievable?
    var onDataRecieved: (() -> Void)?

    init(cellSpacing: CGFloat = 10,
         numberOfCells: CGFloat = 1,
         uiMode: CollectionViewMode = .Boro,
         boroModel: BoroRetrievable = BoroModel(),
         client: DataRetrievable = NYCAPIClient()) {
        self.cellSpacing = cellSpacing
        self.numberOfCells = numberOfCells
        self.numberOfSpaces = numberOfCells + 1
        self.uiMode = uiMode
        self.boros = boroModel.getBoros()
        self.client = client
    }

    func getBoroCellViewModel(indexPath: IndexPath) -> BoroCellModeling {
        let viewModel = BoroCellViewModel(boro: boros[indexPath.row])
        return viewModel
    }

    func getSchoolCellViewModel(indexPath: IndexPath) -> SchoolCellModeling {
        let viewModel = SchoolCellViewModel(school: schools[indexPath.row])
        return viewModel
    }

    func setUIMode(mode: CollectionViewMode) {
        uiMode = mode
    }

    func setBoro(boro: EndpointBuilder.Boro) {
        selectedBoro = boro
    }

    func getSchools(with boro: EndpointBuilder.Boro) {
        //check to see if we already have schools cached for this boro
        //if so then use that data
        //if not then make api call for data
        let cachedSchools = DataCache.shared.getSchools(for: boro)
        if cachedSchools.count != 0 {
            schools = cachedSchools
        } else {
            client?.getSchoolsBy(boro: boro, completion: { [weak self] (result) in
                switch result {
                case .success(let data):
                    for school in data {
                        self?.schools.append(school)
                    }
                    DataCache.shared.cacheSchools(schools: data)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

    func getNextSchools(with boro: EndpointBuilder.Boro, offset: Int){
        //make api call for more data
        //then cache new data
        client?.getNextSchoolsBy(boro: boro, offset: schools.count, completion: { [weak self] (result) in
            switch result {
            case .success(let data):
                for school in data {
                    self?.schools.append(school)
                }
                DataCache.shared.cacheSchools(schools: data)
            case .failure(let error):
                print(error)
            }
        })
    }

    func resetSchools() {
        schools = []
    }
}
