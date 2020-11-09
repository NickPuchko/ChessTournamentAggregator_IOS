//
// Created by Administrator on 05.11.2020.
//

import Foundation

class TournamentsConfigurator: TournamentsConfiguratorProtocol {
    func configure(with viewController: TournamentsViewController) {
        let presenter = TournamentsPresenter(view: viewController)
        let interactor = TournamentsInteractor(presenter: presenter, ref: viewController.ref, phone: viewController.phone)
        let router = TournamentsRouter(VC: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
