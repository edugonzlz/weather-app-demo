import Foundation

struct AirPollutionInfo: Codable {
    let airQuality: AirQuality
    let components: [AirComponent]
    let date: Date
}
