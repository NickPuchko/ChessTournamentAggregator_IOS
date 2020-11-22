//
// Created by Administrator on 21.11.2020.
//

import Foundation

class ProfileConfigurator: ProfileConfiguratorProtocol {
    func configure(with viewController: ProfileViewController) {
        let presenter = ProfilePresenter(view: viewController)
        let interactor = ProfileInteractor(presenter: presenter, ref: viewController.ref, phone: viewController.phone)
        let router = ProfileRouter(VC: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
