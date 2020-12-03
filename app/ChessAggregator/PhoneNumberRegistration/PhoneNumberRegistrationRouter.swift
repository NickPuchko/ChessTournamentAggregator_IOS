//
//  PhoneNumberRegistrationRouter.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import UIKit
import FlagPhoneNumber

final class PhoneNumberRegistrationRouter: BaseRouter {
    weak var listController: FPNCountryListViewController?
}

extension PhoneNumberRegistrationRouter: PhoneNumberRegistrationRouterInput {
    func showCountryList() {
        guard let listVC = listController else {fatalError("wtf no listController")}
        let navVC = UINavigationController(rootViewController: listVC)
        navigationController?.present(navVC, animated: true, completion: nil)
    }

    func showSignUp(phoneNumber: String) {
        let context = UserRegistrationContext(moduleOutput: self, phoneNumber: phoneNumber)
        let container = UserRegistrationContainer.assemble(with: context)
        self.navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension PhoneNumberRegistrationRouter: UserRegistrationModuleOutput {

}
