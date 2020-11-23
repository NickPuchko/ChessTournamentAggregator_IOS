//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation

class AuthRouter: BaseRouter {
}

extension AuthRouter: AuthRouterInput {
    func showPhoneSignUp() {
        let context = PhoneNumberRegistrationContext(moduleOutput: self)
        let container = PhoneNumberRegistrationContainer.assemble(with: context)
        self.navigationController?.pushViewController(container.viewController, animated: true)
    }
}

extension AuthRouter: PhoneNumberRegistrationModuleOutput {
    func didLogin() {
    }

}