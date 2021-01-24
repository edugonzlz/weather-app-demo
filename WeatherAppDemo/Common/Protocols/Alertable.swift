import UIKit

protocol Alertable {
    func showAlert(title: String, message: String)
}

extension Alertable where Self: UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = AlertController.alert(title: title, message: message)
        
        present(alertController, animated: true, completion: nil)
    }
}

