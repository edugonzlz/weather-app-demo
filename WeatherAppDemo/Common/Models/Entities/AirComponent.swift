import Foundation

struct AirComponent: Codable {
    
    var unit = "μg/m3"
    let name: Name
    let value: Double
    
    enum Name: String, Codable {
        case co, no, no2, o3, so2, pm2_5, pm10, nh3
        
        var name: String {
            switch self {
            case .co:
                return "CO (Carbon monoxide)"
            case .no:
                return "NO (Nitrogen monoxide)"
            case .no2:
                return "NO2 (Nitrogen dioxide)"
            case .o3:
                return "O3 (Ozone)"
            case .so2:
                return "SO2 (Sulphur dioxide)"
            case .pm2_5:
                return "PM2.5 (Fine particles matter)"
            case .pm10:
                return "PM10 (Coarse particulate matter)"
            case .nh3:
                return "NH3 (Ammonia)"
            }
        }
    }
}
