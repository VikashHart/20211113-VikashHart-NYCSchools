import UIKit

class SchoolCell: UICollectionViewCell {
    var viewModel: SchoolCellModeling = SchoolCellViewModel(school: SchoolData(schoolID: "", schoolName: "", boro: "", schoolBio: "", academicOpportunities1: "", academicOpportunities2: "", academicOpportunities3: "", academicOpportunities4: "", academicOpportunities5: "", ellPrograms: "", languageClasses: "", apCourses: "", diplomaEndorsements: "", neighborhood: "", location: "", phoneNumber: "", faxNumber: "", schoolEmail: "", website: "", subway: "", bus: "", finalGrades: "", totalStudents: "", startTime: "", endTime: "", additionalInfo: "", extracurricularActivities: "", psalSportsBoys: "", psalSportsGirls: "", psalSportsCoed: "", graduationRate: "", attendanceRate: "", collegeCareerRate: "", primaryAddress: "", city: "", zip: "", stateCode: "", latitude: "", longitude: ""))

    //MARK: - Objects
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Bold", size: 60)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var neighborhoodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "AvenirNext-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.black.cgColor
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

    func setViewModel(viewModel: SchoolCellModeling) {
        self.viewModel = viewModel
        updateUI()
    }

    private func updateUI() {
        schoolLabel.text = viewModel.school.schoolName
        neighborhoodLabel.text = viewModel.school.neighborhood
    }

    private func setupViews() {
        setupSchoolLabel()
        setupNeighborhoodLabel()
    }

    //MARK: - Constraints
    private func setupSchoolLabel() {
        addSubview(schoolLabel)
        NSLayoutConstraint.activate([
            schoolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            schoolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            schoolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            schoolLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }

    private func setupNeighborhoodLabel() {
        addSubview(neighborhoodLabel)
        NSLayoutConstraint.activate([
            neighborhoodLabel.topAnchor.constraint(equalTo: schoolLabel.bottomAnchor, constant: 20),
            neighborhoodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            neighborhoodLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            neighborhoodLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
