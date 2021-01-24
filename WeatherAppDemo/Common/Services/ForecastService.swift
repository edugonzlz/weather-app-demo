import Foundation

protocol ForecastServiceType {
    func getCurrentAirQuality(coordinates: Coordinates, completion: @escaping (Result<ForecastEntity, Error>) -> Void)
    func getForecast(coordinates: Coordinates, completion: @escaping (Result<ForecastEntity, Error>) -> Void)
}

class ForecastService {
    
    private let requestManager: RequestManagerType
    
    init(requestManager: RequestManagerType) {
        self.requestManager = requestManager
    }
}

extension ForecastService: ForecastServiceType {
    func getCurrentAirQuality(coordinates: Coordinates, completion: @escaping (Result<ForecastEntity, Error>) -> Void) {
        guard var url = URL(string: URLConstants.host) else {
            preconditionFailure("Failed to construct URL")
        }
        url.appendPathComponent(URLConstants.airPollution)
        
        let finalURL = url.appending("lat", value: "\(coordinates.latitud)")
            .appending("lon", value: "\(coordinates.longitud)")
            .appending("appid", value: Config.appId)
        
        let request = requestManager.configureRequest(method: .get, url: finalURL, parameters: nil, headers: nil)
        
        requestManager.requestEntity(urlRequest: request) { (result :Result<ForecastEntity, Error>) in
            completion(result)
        }
    }
    
    func getForecast(coordinates: Coordinates, completion: @escaping (Result<ForecastEntity, Error>) -> Void) {
        guard var url = URL(string: URLConstants.host) else {
            preconditionFailure("Failed to construct URL")
        }
        url.appendPathComponent(URLConstants.airPollution)
        url.appendPathComponent(URLConstants.forecast)
        
        let finalURL = url.appending("lat", value: "\(coordinates.latitud)")
            .appending("lon", value: "\(coordinates.longitud)")
            .appending("appid", value: Config.appId)
        
        let request = requestManager.configureRequest(method: .get, url: finalURL, parameters: nil, headers: nil)
        
        requestManager.requestEntity(urlRequest: request) { (result :Result<ForecastEntity, Error>) in
            completion(result)
        }
    }
}
