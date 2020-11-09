//
// Created by Administrator on 05.11.2020.
//

import UIKit

protocol Auth_ConfiguratorProtocol: class {
    func configure(with viewController: Auth_ViewController)
}

protocol Auth_ViewProtocol: class {
    var authView: AuthView { get }
}

protocol Auth_PresenterProtocol: class {
    var router: Auth_RouterProtocol! { get set }
    func configureView()
    func didTapLogin()
    func didTapSignup()
}

protocol Auth_InteractorProtocol: class {
}

protocol Auth_RouterProtocol: class {
    func showTournaments(withId phone: String)
    func showSignup()
}

