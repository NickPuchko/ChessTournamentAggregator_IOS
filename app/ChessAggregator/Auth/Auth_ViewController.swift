//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit
import Firebase

class Auth_ViewController: UIViewController, Auth_ViewProtocol {

    let ref: DatabaseReference!
    var presenter: Auth_PresenterProtocol!
    let configurator: Auth_ConfiguratorProtocol!

    var authView: AuthView {
        view as! AuthView
    }

    required init(ref: DatabaseReference) {
        self.ref = ref
        self.configurator = Auth_Configurator()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = AuthView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()

        title = "Вход"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))

        authView.onTapLoginButton = { [weak self] in
            saveUser(currentUser: User())
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