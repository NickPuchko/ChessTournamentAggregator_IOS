//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

class Auth_Router: Auth_RouterProtocol {
    weak var viewController: Auth_ViewController!

    init(VC: Auth_ViewController) {
        self.viewController = VC
    }

    func showTournaments(withId phone: String) {
        //TODO: dismiss self
        //let vc = TournamentsViewController(ref: viewController.ref, phone: phone)
        let vc = TabBarController(ref: viewController.ref, phone: phone)

        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func showSignup() {
        viewController.navigationController?.pushViewController(
                NumberRegistrationViewController(ref: viewController.ref),
                animated: true
        )
//        let alert = UIAlertController(title: "Nope", message: "Регистрация в разработке...", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive))
//        viewController.present(alert, animated: true)

    }

}
