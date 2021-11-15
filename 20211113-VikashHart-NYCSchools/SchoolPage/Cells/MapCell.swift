import UIKit
import MapKit

class MapCell: UITableViewCell {

    //MARK: - Objects
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2000)
        map.isScrollEnabled = false
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: "mapCell")
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

    func setCoordinates(lat: Double, long: Double) {
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let school = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        school.coordinate = coordinate
        mapView.addAnnotation(school)
//        mapView.addAnnotation(MKMarkerAnnotationView())
    }

    private func setupViews() {
        setupMap()
    }

    //MARK: - Constraints
    private func setupMap() {
        let mapContainer = UIView()
        mapContainer.translatesAutoresizingMaskIntoConstraints = false
        mapContainer.backgroundColor = .red
        contentView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapView.heightAnchor.constraint(greaterThanOrEqualTo: contentView.widthAnchor, multiplier: 0.5)
//            mapView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
}
