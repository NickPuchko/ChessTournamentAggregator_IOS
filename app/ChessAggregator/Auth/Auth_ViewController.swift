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

        view.backgroundColor = .white
        title = "Авторизация"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))

        authView.onTapLoginButton = { [weak self] in
//            let alert = UIAlertController(title: "Мы вошли!", message: "На самом деле нет. Ждём Firebase", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ну ладно", style: .default, handler: { _ in  NSLog("Enter alert occurred")}))
//            self?.present(alert, animated: true, completion: nil)
        //let number = authView.phoneTextField.text!
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