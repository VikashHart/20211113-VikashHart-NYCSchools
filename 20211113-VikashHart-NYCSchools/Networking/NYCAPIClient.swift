import Foundation

protocol SchoolsRetrievable {
    func getSchoolsBy(boro: EndpointBuilder.Boro, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void)
    func getNextSchoolsBy(boro: EndpointBuilder.Boro, offset: Int, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void)
    func getSchoolsBy(query: String, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void)
    func getNextSchoolsBy(query: String, offset: Int, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void)
}

protocol ScoresRetrievable {
    func getSATScores(schoolID: String, completion: @escaping (Result<[SATData], NetworkError>) -> Void)
}

protocol DataRetrievable: SchoolsRetrievable, ScoresRetrievable {
}

//protocol conformance to ensure all api calls are available
class NYCAPIClient: DataRetrievable {
    private let client: DataRetrieving

    init(dataRetriever: DataRetrieving = NetworkClient()) {
        self.client = dataRetriever
    }

    func getSchoolsBy(boro: EndpointBuilder.Boro, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void) {
        getSchoolData(request: URLRequest(url: EndpointBuilder.schoolEndpoint(boro)),
                      completion: completion)
    }

    func getNextSchoolsBy(boro: EndpointBuilder.Boro, offset: Int, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void) {
        getSchoolData(request: URLRequest(url: EndpointBuilder.nextSchoolsEndpoint(boro, offset: offset)),
                      completion: completion)
    }

    func getSchoolsBy(query: String, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void) {
        getSchoolData(request: URLRequest(url: EndpointBuilder.searchEndpoint(query)),
                      completion: completion)
    }

    func getNextSchoolsBy(query: String, offset: Int, completion: @escaping (Result<[SchoolData], NetworkError>) -> Void) {
        getSchoolData(request: URLRequest(url: EndpointBuilder.nextSearchEndpoint(query, offset: offset)),
                      completion: completion)
    }

    //Single func that only requires the URL request to reduce repeated code
    private func getSchoolData(request: URLRequest,
                               completion: @escaping (Result<[SchoolData], NetworkError>) -> Void) {
        client.get(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let schoolModel = try JSONDecoder().decode([SchoolData].self, from: data)
                    completion(.success(schoolModel))
                } catch {
                    completion(.failure(NetworkError.jsonDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getSATScores(schoolID: String, completion: @escaping (Result<[SATData], NetworkError>) -> Void) {
        getSATData(request: URLRequest(url: EndpointBuilder.scoresEndpoint(schoolID)),
                      completion: completion)
    }

    private func getSATData(request: URLRequest,
                               completion: @escaping (Result<[SATData], NetworkError>) -> Void) {
        client.get(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let satModel = try JSONDecoder().decode([SATData].self, from: data)
                    completion(.success(satModel))
                } catch {
                    completion(.failure(NetworkError.jsonDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
