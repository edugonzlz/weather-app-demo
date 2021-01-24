import UIKit

enum AirQuality: Int, Codable {
    case good = 1, fair, moderate, poor, veryPoor
    
    var name: String {
        switch self {
        case .good:
            return "Good"
        case .fair:
            return "Fair"
        case .moderate:
            return "Moderate"
        case .poor:
            return "Poor"
        case .veryPoor:
            return "Very Poor"
        }
    }
    
    var color: UIColor {
        switch self {
        case .good:
            return .green
        case .fair:
            return .systemGreen
        case .moderate:
            return .yellow
        case .poor:
            return .red
        case .veryPoor:
            return .systemRed
        }
    }
}
