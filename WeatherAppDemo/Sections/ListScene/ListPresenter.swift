import Foundation

protocol ListPresenterType {
    func getData()
    func navigateTo(detail indexPath: IndexPath)
}

struct ListTableData {
    let title: String = Config.demoCityName
    var sections: [(date: Date, data: [AirPollutionInfo])]
}

class ListPresenter {

    // MARK: - Public
    var interactor: ListInteractorType?
    
    // MARK: - Private
    private var wireframe: ListWireframeType
    private weak var viewController: ListViewControllerType?
    private var tableData: ListTableData?
    
    // MARK: - Init
    init(wireframe: ListWireframeType,
         viewController: ListViewControllerType) {
        self.wireframe = wireframe
        self.viewController = viewController
    }
}

// MARK: - ListPresenterType
extension ListPresenter: ListPresenterType {
    func getData() {
        viewController?.showLoading()
        interactor?.getData()
    }

    func navigateTo(detail indexPath: IndexPath) {
        if let data = tableData?.sections[indexPath.section].data {
            wireframe.navigateTo(detail: data[indexPath.row].components)
        }
    }
}

// MARK: - ListInteractorOutput
extension ListPresenter: ListInteractorOutput {
    func presentCity(data: (date: Date, data: [AirPollutionInfo])) {
        tableData = ListTableData(sections: [data])
        viewController?.present(data: tableData!)
    }
    
    func presentForecast(data: [(date: Date, data: [AirPollutionInfo])]) {
        tableData?.sections.append(contentsOf: data)
        guard let tableData = tableData else {
            viewController?.hideLoading()
            return
        }
        viewController?.present(data: tableData)
        viewController?.hideLoading()
    }
    
    func presentError(title: String, message: String) {
        viewController?.hideLoading()
        viewController?.showAlert(title: title, message: message)
    }
}
