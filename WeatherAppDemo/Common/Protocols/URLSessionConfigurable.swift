import Foundation

protocol URLSessionConfigurable {
    func getURLSesssion() -> URLSession
}

extension URLSessionConfigurable {
    func getURLSesssion() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 6
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: configuration)
    }
}
