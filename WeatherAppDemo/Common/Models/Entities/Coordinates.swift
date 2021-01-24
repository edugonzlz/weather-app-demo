import Foundation

struct Coordinates: Codable {
    let longitud: Double
    let latitud: Double
    
    enum CodingKeys: String, CodingKey {
        case longitud = "lon"
        case latitud = "lat"
    }
}
