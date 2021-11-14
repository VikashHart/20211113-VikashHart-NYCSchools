import Foundation

//Endpoint builder to avoid unnecessary hard coded values in the API client & to keep the code clean
struct EndpointBuilder {
    enum Boro {
        case brooklyn
        case bronx
        case manhattan
        case queens
        case statenIsland
    }

    static private let schoolAPIBase = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json?"
    static private let scoreAPIBase = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?"
    static private let limit = "&$limit=20"
    static private let initialOffset = "&$offset=0"
    static private let nextOffset = "&$offset="
    static private let order = "&$order=:id"
    static private let searchParam = "$q="
    static private let schoolParam = "dbn="

    static func schoolEndpoint(_ location: Boro) -> URL {
        let limit = String(limit + initialOffset + order)
        let boro: String
        switch location {
        case .brooklyn: boro = "boro=K"
        case .bronx: boro = "boro=X"
        case .manhattan: boro = "boro=M"
        case .queens: boro = "boro=Q"
        case .statenIsland: boro = "boro=R"
        }
        return URL(string: schoolAPIBase + boro + limit)!
    }

    static func nextSchoolsEndpoint(_ location: Boro, offset: Int) -> URL {
        let limit = "\(limit)\(nextOffset)\(offset)\(order)"
        let boro: String
        switch location {
        case .brooklyn: boro = "boro=K"
        case .bronx: boro = "boro=X"
        case .manhattan: boro = "boro=M"
        case .queens: boro = "boro=Q"
        case .statenIsland: boro = "boro=R"
        }
        return URL(string: schoolAPIBase + boro + limit)!
    }

    static func scoresEndpoint(_ schoolID: String) -> URL {
        let endpoint = "\(scoreAPIBase)\(schoolParam)\(schoolID)"
        return URL(string: endpoint)!
    }

    static func searchEndpoint(_ query: String) -> URL {
        let endpoint = String(schoolAPIBase + searchParam + query + limit + initialOffset + order)
        return URL(string: endpoint)!
    }

    static func nextSearchEndpoint(_ query: String, offset: Int) -> URL {
        let search = String(schoolAPIBase + searchParam + query)
        let limits = "\(limit)\(nextOffset)\(offset)\(order)"
        let endpoint = search + limits
        return URL(string: endpoint)!
    }
}
