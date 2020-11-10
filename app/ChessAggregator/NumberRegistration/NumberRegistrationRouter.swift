//
// Created by Иван Лизогуб on 09.11.2020.
//

import UIKit
import FlagPhoneNumber

class NumberRegistrationRouter: NumberRegistrationRouterProtocol {
    weak var viewController: NumberRegistrationViewController!

    init(viewController: NumberRegistrationViewController) {
        self.viewController = viewController
    }

    func showNextRegistrationField(phoneNumber: String) {
        viewController.navigationController?.pushViewController(
                RegistrationViewController(ref: viewController.ref, withPhoneNumber: phoneNumber),
                animated: true
        )
    }

    func showFPNCountryList() {
        let navigationViewController = UINavigationController(rootViewController: viewController.listController)
        viewController.present(navigationViewController, animated: true, completion: nil)
    }
}