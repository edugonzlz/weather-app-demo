import Foundation

protocol RequestManagerType {
    
    var urlSession: URLSession { get set }

    func configureRequest(method: HTTPMethod, url: URL, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest
    
    func requestEntity<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

class RequestManager: RequestManagerType {
    
    var urlSession: URLSession = URLSession.shared

    func configureRequest(method: HTTPMethod, url: URL, parameters: [String: Any]?, headers: [String: String]?) -> URLRequest {
        var request =  URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            headers.forEach({request.addValue($0.value, forHTTPHeaderField: $0.key)})
        }
        if let params = parameters,
           let httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])  {
            request.httpBody = httpBody
        }
        return request
    }
    
    func requestEntity<T: Decodable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        self.request(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                if let entity = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(entity))
                } else {
                    print("ERROR: \(Errors.wrongJSONFormat("\(T.self)"))")
                    completion(.failure(Errors.wrongJSONFormat("\(T.self)")))
                }
            case .failure(let error):
                print("ERROR: \(error)")
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Request
private extension RequestManager {
    
    func request(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        print("REQUEST: \(urlRequest)")
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                print("RESPONSE: \(String(describing: response)), DATA: \(String(describing: String(data: data, encoding: .utf8)))")
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else if let error = error {
                print("RESPONSE: \(String(describing: response)), ERROR: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

