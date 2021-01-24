import Foundation

struct ForecastEntity: Codable {
    let coordinates: Coordinates
    let airPollutionInfo: [AirPollutionInfo]
    
    private struct List: Codable {
        let main: Main
        let components: [String: Double]
        let dt: Double
        
        struct Main: Codable {
            let aqi: Int
        }
    }
    
    enum ForecastKeys: String, CodingKey {
        case list
        case coord
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ForecastKeys.self)
        coordinates = try values.decode(Coordinates.self, forKey: .coord)
        
        let list = try values.decode([List].self, forKey: .list)
        var airPollutionInfo = [AirPollutionInfo]()
        list.forEach({ item in
            var components =  [AirComponent]()
            item.components.forEach({ key, value in
                guard let name = AirComponent.Name(rawValue: key) else { return }
                let ac = AirComponent(name: name, value: value)
                components.append(ac)
            })
            let info = AirPollutionInfo(airQuality: AirQuality(rawValue: item.main.aqi)!,
                                        components: components,
                                        date: Date.init(timeIntervalSince1970: item.dt))
            airPollutionInfo.append(info)
        })
        self.airPollutionInfo = airPollutionInfo
    }
}
