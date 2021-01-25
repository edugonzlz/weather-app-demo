import UIKit

protocol ListWireframeType {
    mutating func setup() -> UIViewController
    func navigateTo(detail: [AirComponent])
}

class ListWireframe: ListWireframeType {

    weak var viewController: UIViewController?

    func setup() -> UIViewController {
        let viewController = ListViewController()
        let presenter = ListPresenter(wireframe: self, viewController: viewController)
        let requestManager = RequestManager()
        let interactor = ListInteractor(forecastService: ForecastService(requestManager: requestManager))
        let urlSession = interactor.getURLSesssion()
        
        requestManager.urlSession = urlSession
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.output = presenter
        self.viewController = viewController
        
        return viewController
    }
    
    func navigateTo(detail: [AirComponent]) {
        let viewController = DetailWireframe(viewController: self.viewController, data: detail).setup()
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
