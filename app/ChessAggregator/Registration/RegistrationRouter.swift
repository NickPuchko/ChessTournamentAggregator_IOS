//
// Created by Иван Лизогуб on 05.11.2020.
//

import Foundation

class RegistrationRouter: RegistrationRouterProtocol {

    weak var viewController: RegistrationViewController!

    init(viewController: RegistrationViewController) {
        self.viewController = viewController
    }


    func goToTournamentsWindow(withPhoneNumber phoneNumber: String) {
        viewController.navigationController?.pushViewController(
                TournamentsViewController(ref: viewController.ref, phone: phoneNumber),
                animated: true
        )
    }
}