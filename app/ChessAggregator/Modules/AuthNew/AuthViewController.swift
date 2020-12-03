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

    private lazy var adapter = KeyboardAdapter(window: self.view.window) { [weak self] offset, duration in
        self?.keyboardOffsetChanged(offset, duration: duration)
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
            self?.output?.onTapLogin(
                    email: self?.authView.emailTextField.text ?? "",
                    password: self?.authView.passwordTextField.text ?? ""
            )
        }

        authView.onTapSignupButton = { [weak self] in
            self?.output?.onTapSignUp()
        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.adapter.start()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.adapter.stop()
    }
}

extension AuthViewController: AuthViewInput {

}

private extension AuthViewController {
    func keyboardOffsetChanged(_ offset: CGFloat, duration: TimeInterval) {
        let keyboardFrame = self.view.window!.frame.height - offset
        let authOffset = self.authView.signupButtonMaxY - keyboardFrame > 0 ? self.authView.signupButtonMaxY - keyboardFrame : 0
        UIView.animate(withDuration: duration) {
            self.authView.stackViewBottomConstraint?.constant = self.authView.stackViewBottomConstraintConstant - authOffset
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
}