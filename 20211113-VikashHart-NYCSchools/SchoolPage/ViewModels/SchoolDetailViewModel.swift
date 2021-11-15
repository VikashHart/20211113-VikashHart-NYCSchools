import Foundation

protocol SchoolDetailModeling {
    var school: SchoolData { get }
    var satScores: SATData? { get }
    var sectionData: [Int: SectionInfo] { get }
    var sectionKindToSectionNumber: [SectionInfo.Kind: Int] { get }
    var onSectionDataUpdated: (() -> Void)? { get set }
}

protocol SchoolDetailContent {
    var kind: SchoolDetailKind { get }
}

enum SchoolDetailKind {
    case plainText
    case loader
    case map
}

class SchoolDetailViewModel: SchoolDetailModeling {
    var school: SchoolData
    var satScores: SATData? {
        didSet {
            DispatchQueue.main.async {
                self.updateSATSection(satData: self.satScores)
            }
        }
    }

    var sectionData: [Int: SectionInfo] = [:]
    var sectionKindToSectionNumber: [SectionInfo.Kind: Int] = [:]
    var onSectionDataUpdated: (() -> Void)?

    private let client: ScoresRetrievable
    private let cache: DataCaching

    init(school: SchoolData,
         client: ScoresRetrievable = NYCAPIClient(),
         cache: DataCaching = DataCache.shared) {
        self.school = school
        self.client = client
        self.cache = cache
        getSATScore()
        buildContent(school: school)
    }

    func getSATScore() {
        //check to see if we already have scores cached for this school
        //if so then use that data
        //if not then make api call for data
        if let cachedSatScores = cache.getSATScore(for: school.schoolID) {
            satScores = cachedSatScores
        } else {
            client.getSATScores(schoolID: school.schoolID) { [weak self] (result) in
                switch result {
                case .success(let data):
                    guard data.count > 0 else {
                        self?.satScores = nil
                        return
                    }
                    self?.satScores = data[0]
                    self?.cache.cacheSATData(satData: data[0])
                case .failure(let error):
                    print(error)
                    self?.satScores = nil
                }
            }
        }
    }

    func buildContent(school: SchoolData) {
        var sectionNumber = 0
        let generalInfo = buildGeneralInfo(school: school)
        sectionData[sectionNumber] = generalInfo
        sectionKindToSectionNumber[.general] = sectionNumber

        sectionNumber = 1
        if let bio = buildBio(school: school) {
            sectionData[sectionNumber] = bio
            sectionKindToSectionNumber[.bio] = sectionNumber
            sectionNumber = sectionNumber + 1
        }

        if let programs = buildPrograms(school: school) {
            sectionData[sectionNumber] = programs
            sectionKindToSectionNumber[.programs] = sectionNumber
            sectionNumber = sectionNumber + 1
        }

        let satContent: SectionInfo
        if let satData = satScores {
            satContent = buildSATSection(satData: satData)
        } else {
            satContent = buildSATLoadingSection()
        }
        sectionData[sectionNumber] = satContent
        sectionKindToSectionNumber[.SAT] = sectionNumber
        sectionNumber = sectionNumber + 1

        if let location = buildLocation(school: school) {
            sectionData[sectionNumber] = location
            sectionKindToSectionNumber[.location] = sectionNumber
            sectionNumber = sectionNumber + 1
        }
    }

    func buildGeneralInfo(school: SchoolData) -> SectionInfo {
        let name = PlainTextContent(text: school.schoolName)
        let neighborhood = PlainTextContent(text: school.neighborhood)

        return SectionInfo(headerTitle: "General",
                           content: [name, neighborhood])
    }

    func buildBio(school: SchoolData) -> SectionInfo? {
        guard let bioString = school.schoolBio else {
            return nil
        }
        let bio = PlainTextContent(text: bioString)
        return SectionInfo(headerTitle: "Bio", content: [bio])
    }

    func buildPrograms(school: SchoolData) -> SectionInfo? {
        var content: [SchoolDetailContent] = []

        if let ellPrograms = school.ellPrograms {
            content.append(PlainTextContent(text: "ELL Programs: " + ellPrograms))
        }

        if let apCourses = school.apCourses {
            content.append(PlainTextContent(text: "AP Courses: " + apCourses))
        }

        if let languageClasses = school.languageClasses {
            content.append(PlainTextContent(text: "Language Classes: " + languageClasses))
        }

        guard content.count > 0 else {
            return nil
        }

        return SectionInfo(headerTitle: "Programs",
                           content: content)
    }


    func buildSATSection(satData: SATData) -> SectionInfo {
        return SectionInfo(headerTitle: "SAT Stats",
                           content: [
                            PlainTextContent(text: "Reading average: \(satData.readingAvgScore)"),
                            PlainTextContent(text: "Math average: \(satData.mathAvgScore)"),
                            PlainTextContent(text: "Writing average: \(satData.writingAvgScore)")
                           ])
    }

    func buildSATUnavailable() -> SectionInfo {
        return SectionInfo(headerTitle: "SAT Stats",
                           content: [PlainTextContent(text: "Unavailable")])
    }

    func buildSATLoadingSection() -> SectionInfo {
        return SectionInfo(headerTitle: "SAT Stats",
                           content: [LoadingPlaceholder()])
    }

    func updateSATSection(satData: SATData?) {
        var newSectionInfo: SectionInfo
        if let satData = satData {
            newSectionInfo = buildSATSection(satData: satData)
        } else {
            newSectionInfo = buildSATUnavailable()
        }
        guard let section = sectionKindToSectionNumber[.SAT] else {
            return
        }

        sectionData[section] = newSectionInfo
        onSectionDataUpdated?()
    }

    func buildLocation(school: SchoolData) -> SectionInfo? {
        var content: [SchoolDetailContent] = []

        if let addressString = school.location {
            content.append(PlainTextContent(text: "Address: \(addressString)"))
        }

        if let subwayString = school.subway {
            content.append(PlainTextContent(text: "Subway: \(subwayString)"))
        }

        if let busString = school.bus {
            content.append(PlainTextContent(text: "Bus: \(busString)"))
        }

        if let latString = school.latitude, let longString = school.longitude {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 5

            if let lat = formatter.number(from: latString)?.doubleValue, let long = formatter.number(from: longString)?.doubleValue {
                content.append(MapContent(lat: lat, long: long))
            }
        }

        guard content.count > 0 else {
            return nil
        }

        return SectionInfo(headerTitle: "Location",
                           content: content)
    }
}

struct PlainTextContent: SchoolDetailContent {
    let kind = SchoolDetailKind.plainText

    let text: String
}

struct LoadingPlaceholder: SchoolDetailContent {
    let kind = SchoolDetailKind.loader
}

struct MapContent: SchoolDetailContent {
    let kind = SchoolDetailKind.map

    let lat: Double
    let long: Double
}

class SectionInfo {
    enum Kind {
        case bio
        case general
        case location
        case programs
        case SAT
        case additionallInfo
        case academicOps
        case sports
        case extracurricular
        case contact
        case info
    }

    let headerTitle: String
    var content: [SchoolDetailContent]

    init(headerTitle: String,
         content: [SchoolDetailContent]) {
        self.headerTitle = headerTitle
        self.content = content
    }
}
