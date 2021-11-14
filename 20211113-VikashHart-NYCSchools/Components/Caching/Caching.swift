import Foundation

protocol DataCaching {
    func cacheSchools(schools: [SchoolData])
    func cacheSATData(satData: SATData)
    func getSchools(for boro: EndpointBuilder.Boro) -> [SchoolData]
    func getSATScore(for schoolID: String) -> SATData?
}

class DataCache: DataCaching {
    static let shared = DataCache()
    private var schoolCache: [String : SchoolData] = [:]
    private var satCache: [String : SATData] = [:]

    func cacheSchools(schools: [SchoolData]) {
        for school in schools {
            if schoolCache[school.schoolID] != nil {
                // if school exits do nothing
            } else {
                //otherwise add to cache
                schoolCache[school.schoolID] = school
            }
        }
    }

    func cacheSATData(satData: SATData) {
        if satCache[satData.schoolID] != nil {
            // if sat data exists do nothing
        } else {
            // otherwise add to cache
            satCache[satData.schoolID] = satData
        }
    }

    func getSchools(for boro: EndpointBuilder.Boro) -> [SchoolData] {
        var filteredSchools = [SchoolData]()
        //checing to see if schoolCache is empty
        guard schoolCache.count == 0 else { return filteredSchools }

        var borough = ""
        //determining which boro to search against
        switch boro {
        case .brooklyn:
            borough = "K"
        case .bronx:
            borough = "X"
        case .manhattan:
            borough = "M"
        case .queens:
            borough = "Q"
        case .statenIsland:
            borough = "R"
        }

        //loop through schools and if school boro matches then add to filteredSchools array
        for school in schoolCache.values {
            //in the event that the boro was entered with whitespace(s) or in lowercase, we remove them and uppercase before checking
            if school.boro.replacingOccurrences(of: " ", with: "").uppercased() == borough {
                filteredSchools.append(school)
            }
        }

        return filteredSchools
    }

    func getSATScore(for schoolID: String) -> SATData? {
        //check to see if scores exist
        //if so return nil
        //otherwise return scores
        guard let scores = satCache[schoolID] else { return nil }

        return scores
    }
}
