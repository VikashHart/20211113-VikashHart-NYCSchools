import Foundation

protocol SchoolCellModeling {
    var school: SchoolData { get }
}

class SchoolCellViewModel: SchoolCellModeling {
    var school: SchoolData

    init(school: SchoolData) {
        self.school = school
    }
}
