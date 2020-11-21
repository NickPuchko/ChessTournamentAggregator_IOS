
import Foundation
import SafariServices

class CreationRouter: CreationRouterProtocol {
    weak var viewController: CreationViewController!
    init(VC: CreationViewController) {
        self.viewController = VC
    }

    func closeCreation() {
        viewController.dismiss(animated: true) { print("Event added!") }
    }
}
