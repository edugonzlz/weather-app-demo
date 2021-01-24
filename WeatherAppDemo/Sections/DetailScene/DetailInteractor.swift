import Foundation

protocol DetailInteractorType: class {
    var output: DetailInteractorOutput? { get set }
    var data: [AirComponent]? { get set }
    
    func getData()
}

protocol DetailInteractorOutput: class {
    func presentData(data: [AirComponent])
}

class DetailInteractor {
    // MARK: - Public
    weak var output: DetailInteractorOutput?
    var data: [AirComponent]? = nil
}

// MARK: - DetailInteractorType
extension DetailInteractor: DetailInteractorType {
    func getData() {
        guard let data = data else { return }
        output?.presentData(data: data)
    }
}

