//
// Created by Administrator on 05.11.2020.
//

import UIKit

class AuthNewView: AutoLayoutView {
    private lazy var stackView = UIStackView()
    var email: String = "email@example.com"

    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    private let loginButton = UIButton(type: .system)
    private let signupButton = UIButton(type: .system)
    private let forgotButton = UIButton(type: .system)

    var onTapLoginButton: (() -> Void)?
    var onTapSignupButton: (() -> Void)?
    var onTapForgotButton: (() -> Void)?

    var stackViewBottomConstraint: NSLayoutConstraint?
    var stackViewBottomConstraintConstant: CGFloat { -bounds.height/2.0 }
    lazy var signupButtonMaxY: CGFloat = signupButton.frame.maxY

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setup() {
        backgroundColor = .systemGray6

        stackView.axis = .vertical
        stackView.distribution = .fill


        emailTextField.placeholder = "email@gmail.com"
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .roundedRect
        emailTextField.addTarget(self, action: #selector(editPassword), for: .editingDidEndOnExit)


        passwordTextField.placeholder = "Password1234567890"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect


        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)


        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = true
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)

        forgotButton.setTitle("Забыли пароль?", for: .normal)
        forgotButton.addTarget(self, action: #selector(onTapForgot), for: .touchUpInside)


        signupButton.setTitle("Регистрация", for: .normal)
        signupButton.addTarget(self, action: #selector(onTapSignup), for: .touchUpInside)

        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOpacity = 0.3

        addSubview(stackView)
        addSubview(loginButton)
        addSubview(signupButton)
        addSubview(forgotButton)
    }


    override func setupConstraints() {
        super.setupConstraints()

        let margins = layoutMarginsGuide
        stackViewBottomConstraint = stackView.bottomAnchor.constraint(
                equalTo: margins.bottomAnchor,
                constant: -bounds.height/2.0
        )
        [
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            stackViewBottomConstraint!,
//            stackView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: -stackView.bounds.height),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor,constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor,constant: -16.0),

            loginButton.heightAnchor.constraint(equalToConstant: 40.0),
            loginButton.widthAnchor.constraint(equalToConstant: bounds.width/2),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.0),
            loginButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            forgotButton.heightAnchor.constraint(equalToConstant: 40),
            forgotButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10.0),
            forgotButton.widthAnchor.constraint(equalToConstant: bounds.width/2),
            forgotButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            signupButton.heightAnchor.constraint(equalToConstant: 40),
            signupButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 10.0),
            signupButton.widthAnchor.constraint(equalToConstant: bounds.width/2),
            signupButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)

        ].forEach {$0.isActive = true}

    }

    @objc
    private func onTapLogin() {
        email = emailTextField.text ?? "email@example.com"
        onTapLoginButton?()
    }

    @objc
    private func onTapSignup() -> Void {
        onTapSignupButton?()
    }

    @objc
    private func onTapForgot() -> Void {
        onTapForgotButton?()
    }

    @objc
    private func editPassword() {
        if passwordTextField.text == "" {
            passwordTextField.becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
    }
}
