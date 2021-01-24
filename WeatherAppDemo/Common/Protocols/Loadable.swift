import UIKit

protocol Loadable {
    func showLoading()
    func hideLoading()
}

extension Loadable where Self: UIViewController {
    func showLoading() {
        view.showLoading()
    }
    func hideLoading() {
        view.hideLoading()
    }
}


