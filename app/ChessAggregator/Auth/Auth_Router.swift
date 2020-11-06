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

    func showTournaments() {
        //TODO: dismiss self
        let vc = TournamentsViewController()
        viewController.navigationController?.pushViewController(vc, animated: true)


    }

    func showSignup() {
        let alert = UIAlertController(title: "Nope", message: "Регистрация в разработке...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive))
        viewController.present(alert, animated: true)
        //viewController.navigationController?.pushViewController(vc, animated: true)
    }

}
