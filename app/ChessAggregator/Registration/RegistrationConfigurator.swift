//
// Created by Иван Лизогуб on 05.11.2020.
//

import Foundation

class RegistrationConfigurator: RegistrationConfiguratorProtocol {
    func configure(with viewController: RegistrationViewController, andSend phoneNumber: String) {

        let presenter = RegistrationPresenter(view: viewController)
        let interactor = RegistrationInteractor(presenter: presenter, phoneNumber: phoneNumber)
        let router = RegistrationRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}