//
// Created by Administrator on 05.11.2020.
//

import Foundation

class Auth_Configurator: Auth_ConfiguratorProtocol {
    func configure(with viewController: Auth_ViewController) {
        let presenter = Auth_Presenter(view: viewController)
        let interactor = Auth_Interactor(presenter: presenter, ref: viewController.ref)
        let router = Auth_Router(VC: viewController)

        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
