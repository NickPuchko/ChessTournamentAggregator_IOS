//
// Created by Administrator on 10.11.2020.
//

import Foundation

class CurrentConfigurator: CurrentConfiguratorProtocol{
    func configure(with viewController: CurrentViewControllerProtocol) {
        let presenter = CurrentPresenter(view: viewController)
        let interactor = CurrentInteractor(presenter: presenter, ref: viewController.ref, event: viewController.event)
        let router = CurrentRouter(VC: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
