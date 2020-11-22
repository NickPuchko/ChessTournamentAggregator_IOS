import Foundation

class RegistrationRouter: RegistrationRouterProtocol {

    weak var viewController: RegistrationViewController!

    init(viewController: RegistrationViewController) {
        self.viewController = viewController
    }


    func goToTournamentsWindow(withPhoneNumber phoneNumber: String) {
        viewController.navigationController?.pushViewController(
                TabBarController(ref: viewController.ref, phone: phoneNumber),
                //TournamentsViewController(ref: viewController.ref, phone: phoneNumber),
                animated: true
        )
    }
}