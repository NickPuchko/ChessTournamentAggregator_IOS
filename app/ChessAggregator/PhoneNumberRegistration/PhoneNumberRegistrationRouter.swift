//
//  PhoneNumberRegistrationRouter.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import UIKit

final class PhoneNumberRegistrationRouter: BaseRouter {
}

extension PhoneNumberRegistrationRouter: PhoneNumberRegistrationRouterInput {
    func showSignUp(phoneNumber: String) {
        let context = UserRegistrationContext(moduleOutput: self, phoneNumber: phoneNumber)
        let container = UserRegistrationContainer.assemble(with: context)
        let navVC = navigationControllerProvider?()
        navVC?.pushViewController(container.viewController, animated: true)
    }
}

extension PhoneNumberRegistrationRouter: UserRegistrationModuleOutput {

}
