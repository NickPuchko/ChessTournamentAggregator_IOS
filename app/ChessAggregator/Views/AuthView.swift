//
// Created by Administrator on 05.11.2020.
//

import UIKit

class AuthView: AutoLayoutView {
    private lazy var stackView = UIStackView()

    let phoneTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    let signupButton = UIButton(type: .system)

    var onTapLoginButton: (() -> Void)?
    var onTapSignupButton: (() -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setup() {
        stackView.axis = .vertical

        phoneTextField.placeholder = "Введите номер телефона"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.borderStyle = .roundedRect




        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect

        phoneTextField.addTarget(self, action: #selector(didEditedPhone), for: UIControl.Event.editingDidEnd)





        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(passwordTextField)
//        stackView.setCustomSpacing(24, after: passwordTextField)

//        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Введите номер телефона", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
//        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])

        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = false
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)


        signupButton.setTitle("Регистрация", for: .normal)
        signupButton.addTarget(self, action: #selector(onTapSignup), for: .touchUpInside)

        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOpacity = 0.3

        //stackView.addArrangedSubview(loginButton)
    }

    @objc
    func didEditedPhone() {
        let user = User(phone: phoneTextField.text ?? "900")
        saveUser(currentUser: user)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            signupButton.heightAnchor.constraint(equalToConstant: 40)
            //loginButton.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            //loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])

        addSubview(stackView)
        addSubview(loginButton)
        addSubview(signupButton)
        stackView.distribution = .equalCentering

        signupButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true

        loginButton.leading(90)
        loginButton.trailing(-90)
        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true

        signupButton.leading(90)
        signupButton.trailing(-90)

        stackView.top(350)
        stackView.leading(16)
        stackView.trailing(-16)

//        stackView.pins(UIEdgeInsets(top: 300.0, left: 16.0, bottom: -350.0, right: -16.0))
    }

    @objc
    private func onTapLogin() {
        onTapLoginButton?()
    }

    @objc
    private func onTapSignup() {
        onTapSignupButton?()
    }
}