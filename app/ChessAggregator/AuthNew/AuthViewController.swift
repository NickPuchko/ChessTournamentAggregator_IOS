//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import UIKit

class AuthViewController: UIViewController {
    private let output: AuthViewOutput?

    private var authView: AuthNewView {
        view as! AuthNewView
    }

    init(output: AuthViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = AuthNewView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Вход"


        authView.onTapLoginButton = { [weak self] in
            saveUser(currentUser: User())
            self?.output?.onTapLogin()
        }

        authView.onTapSignupButton = { [weak self] in
            self?.output?.onTapSignUp()
        }

    }

}

extension AuthViewController: AuthViewInput {

}