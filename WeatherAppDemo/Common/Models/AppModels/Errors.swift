import Foundation

enum Errors: Error {
    case wrongJSONFormat(String)
    case userNotLogged
}

extension String: Error {
}

typealias ErrorMessage = String
