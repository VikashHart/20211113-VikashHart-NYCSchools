import Foundation

protocol DataRetrieving {
    func get(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

//Reusable Get request for any client classes
class NetworkClient: DataRetrieving {
    func get(request: URLRequest, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in

            guard let data = data else {
                let error = (response as? HTTPURLResponse)?.apiError ?? .unknownError
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
