import Foundation

struct Config {
    static var appId: String {
        return Bundle.main.infoDictionary!["OPEN_WEATHER_MAP_APPID"] as? String ?? ""
    }
    static let demoCoordinates = Coordinates(longitud: 11.57549, latitud: 48.13743)
    static let demoCityName = "Munich"
}
