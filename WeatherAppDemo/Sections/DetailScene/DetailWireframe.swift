import UIKit

protocol DetailWireframeType {
    func setup() -> UIViewController
}

class DetailWireframe: DetailWireframeType {

    weak var viewController: UIViewController?
    private var data: [AirComponent]
    
    init(viewController: UIViewController?, data: [AirComponent]) {
        self.viewController = viewController
        self.data = data
    }
    
    func setup() -> UIViewController {
        let viewController = DetailViewController()
        let presenter = DetailPresenter(wireframe: self, viewController: viewController)
        let interactor = DetailInteractor()
        interactor.data = data
        interactor.output = presenter
        presenter.interactor = interactor
        viewController.presenter = presenter

        return viewController
    }
}
