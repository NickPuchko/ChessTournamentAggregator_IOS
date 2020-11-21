//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation

class AuthRouter: BaseRouter {

    weak var moduleOutput: AuthModuleOutput?
    init(moduleOutput: AuthModuleOutput?) {
        self.moduleOutput = moduleOutput
    }
}

extension AuthRouter: AuthRouterInput {
    func showPhoneSignUp() {
        let context = PhoneNumberRegistrationContext(moduleOutput: self)
        let container = PhoneNumberRegistrationContainer.assemble(with: context)
        let navVC = navigationControllerProvider?()
        navVC?.pushViewController(container.viewController, animated: true)
    }
}

extension AuthRouter: PhoneNumberRegistrationModuleOutput {
    func didLogin() {
    }

}