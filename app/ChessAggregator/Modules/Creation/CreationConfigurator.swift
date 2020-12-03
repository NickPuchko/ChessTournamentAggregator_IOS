//
// Created by Administrator on 21.11.2020.
//

import Foundation

class CreationConfigurator: CreationConfiguratorProtocol {
    func configure(with viewController: CreationViewController) {
        let presenter = CreationPresenter(view: viewController)
        let interactor = CreationInteractor(presenter: presenter, ref: viewController.ref, phone: viewController.phone)
        let router = CreationRouter(VC: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
