//
// Created by Иван Лизогуб on 09.11.2020.
//

import Foundation

class NumberRegistrationConfigurator: NumberRegistrationConfiguratorProtocol {
    func configure(with viewController: NumberRegistrationViewController) {
        let presenter = NumberRegistrationPresenter(view: viewController)
        let interactor = NumberRegistrationInteractor(presenter: presenter)
        let router = NumberRegistrationRouter(viewController: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}