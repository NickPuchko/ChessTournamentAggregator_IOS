//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

protocol Auth_ConfiguratorProtocol: class {
    func configure(with viewController: Auth_ViewController)
}

protocol Auth_ViewProtocol: class {
}

protocol Auth_PresenterProtocol: class {
    var router: Auth_RouterProtocol! { get set }
    func configureView()
    func didTapDone()
    func didTapLogin()
}

protocol Auth_InteractorProtocol: class {
}

protocol Auth_RouterProtocol: class {
    func showTournaments()
    func showSignup()
}

