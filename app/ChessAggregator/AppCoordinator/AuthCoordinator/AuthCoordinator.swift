//
// Created by Иван Лизогуб on 29.11.2020.
//

import UIKit

final class AuthCoordinator {
    private let window: UIWindow
    private var navigationController = UINavigationController()
    weak var appCoordinator: AuthCoordinatorModuleOutput?
    var phoneNumber: String?

    init(window: UIWindow, appCoordinator: AuthCoordinatorModuleOutput) {
        self.window = window
        self.appCoordinator = appCoordinator
    }


    func auth() {
        let context = AuthContext(moduleOutput: self)
        let container = AuthContainer.assemble(with: context)
        self.navigationController.setViewControllers([container.viewController], animated: false)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    func  ForgotPassword() {
        let context = ForgotPasswordContext(moduleOutput: self)
        let container = ForgotPasswordContainer.assemble(with: context)
        self.navigationController.pushViewController(container.viewController, animated: true)
    }
    func phoneNumberSignUp() {
        let context = PhoneNumberRegistrationContext(moduleOutput: self)
        let container = PhoneNumberRegistrationContainer.assemble(with: context)
        self.navigationController.pushViewController(container.viewController, animated: true)
    }

    func userRegistrationSignUp() {
        let context = UserRegistrationContext(moduleOutput: self)
        let container = UserRegistrationContainer.assemble(with: context)
        self.navigationController.pushViewController(container.viewController, animated: true)
    }
}

extension AuthCoordinator: AuthModuleOutput {

    func showForgotPassword() {
        ForgotPassword()
    }

    func showPhoneSignUp() {
        phoneNumberSignUp()
    }

    func didLogin() {
        appCoordinator?.didLogin()
    }

//    func setPhoneNumber(phoneNumber: String) {
//        self.phoneNumber = phoneNumber
//        //appCoordinator?.setPhoneNumber(phoneNumber: phoneNumber)
//    }

}

extension AuthCoordinator: PhoneNumberRegistrationModuleOutput {

    
    func showSignUp() {
        userRegistrationSignUp()
    }

//    func setRegPhoneNumber(phoneNumber: String) {
//        self.phoneNumber = phoneNumber
//        //appCoordinator?.setPhoneNumber(phoneNumber: phoneNumber)
//    }
}
extension AuthCoordinator: ForgotPasswordModuleOutput {
    func showForgot() {
    }
}

extension AuthCoordinator: UserRegistrationModuleOutput {
    func didRegister() {
        appCoordinator?.didLogin()
    }
}
