import UIKit

protocol AppWireframeType {
    func start()
}

class AppWireframe {
	
	private weak var window: UIWindow?
    
    init(_ window: UIWindow?) {
        self.window = window
    }
}

extension AppWireframe: AppWireframeType {
    func start() {
        let listViewController = ListWireframe().setup()
        let navVC = UINavigationController(rootViewController: listViewController)

        window?.rootViewController = navVC
    }
}
