import Foundation

struct SchoolData: Codable {
    let schoolID: String
    let schoolName: String
    let boro: String
    let schoolBio: String?
    let academicOpportunities1: String?
    let academicOpportunities2: String?
    let academicOpportunities3: String?
    let academicOpportunities4: String?
    let academicOpportunities5: String?
    let ellPrograms: String?
    let languageClasses: String?
    let apCourses: String?
    let diplomaEndorsements: String?
    let neighborhood: String
    let location: String?
    let phoneNumber: String?
    let faxNumber: String?
    let schoolEmail: String?
    let website: String?
    let subway: String?
    let bus: String?
    let finalGrades: String?
    let totalStudents: String?
    let startTime: String?
    let endTime: String?
    let additionalInfo: String?
    let extracurricularActivities: String?
    let psalSportsBoys: String?
    let psalSportsGirls: String?
    let psalSportsCoed: String?
    let graduationRate: String?
    let attendanceRate: String
    let collegeCareerRate: String?
    let primaryAddress: String
    let city: String
    let zip: String
    let stateCode: String
    let latitude: String?
    let longitude: String?

    //Using coding keys to shorten & simplify keynames & to avoid snakecase
    enum CodingKeys: String, CodingKey {
        case schoolID = "dbn"
        case schoolName = "school_name"
        case boro
        case schoolBio = "overview_paragraph"
        case academicOpportunities1 = "academicopportunities1"
        case academicOpportunities2 = "academicopportunities2"
        case academicOpportunities3 = "academicopportunities3"
        case academicOpportunities4 = "academicopportunities4"
        case academicOpportunities5 = "academicopportunities5"
        case ellPrograms = "ell_programs"
        case languageClasses = "language_classes"
        case apCourses = "advancedplacement_courses"
        case diplomaEndorsements = "diplomaendorsements"
        case neighborhood
        case location
        case phoneNumber = "phone_number"
        case faxNumber = "fax_number"
        case schoolEmail = "school_email"
        case website
        case subway
        case bus
        case finalGrades = "finalgrades"
        case totalStudents = "total_students"
        case startTime = "start_time"
        case endTime = "end_time"
        case additionalInfo =  "addtl_info1"
        case extracurricularActivities = "extracurricular_activities"
        case psalSportsBoys = "psal_sports_boys"
        case psalSportsGirls = "psal_sports_girls"
        case psalSportsCoed = "psal_sports_coed"
        case graduationRate = "graduation_rate"
        case attendanceRate = "attendance_rate"
        case collegeCareerRate = "college_career_rate"
        case primaryAddress = "primary_address_line_1"
        case city
        case zip
        case stateCode = "state_code"
        case latitude
        case longitude
    }
}
