import Foundation

protocol DetailPresenterType {
    func getData()
}

class DetailPresenter {

    // MARK: - Public
    var interactor: DetailInteractorType?
    
    // MARK: - Private
    private var wireframe: DetailWireframeType
    private weak var viewController: DetailViewControllerType?
    
    // MARK: - Init
    init(wireframe: DetailWireframeType,
         viewController: DetailViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

// MARK: - DetailPresenterType
extension DetailPresenter: DetailPresenterType {
    func getData() {
        interactor?.getData()
    }
}

// MARK: -
extension DetailPresenter: DetailInteractorOutput {
    func presentData(data: [AirComponent]) {
        viewController?.present(data: data)
    }
}
