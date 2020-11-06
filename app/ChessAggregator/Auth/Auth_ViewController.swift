//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

class Auth_ViewController: UIViewController, Auth_ViewProtocol {

    var presenter: Auth_PresenterProtocol!
    let configurator: Auth_ConfiguratorProtocol! = Auth_Configurator()

    var authView: AuthView {
        view as! AuthView
    }


    override func loadView() {
        view = AuthView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()

        view.backgroundColor = .white
        title = "Авторизация"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))

        authView.onTapLoginButton = { [weak self] in
//            let alert = UIAlertController(title: "Мы вошли!", message: "На самом деле нет. Ждём Firebase", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ну ладно", style: .default, handler: { _ in  NSLog("Enter alert occurred")}))
//            self?.present(alert, animated: true, completion: nil)

            self?.presenter.didTapLogin()
        }

        authView.onTapSignupButton = { [weak self] in
            self?.presenter.didTapSignup()
        }

    }

    @objc
    func didTapDone() {

    }


}