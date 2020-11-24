//
// Created by Administrator on 05.11.2020.
//

import UIKit

class AuthNewView: AutoLayoutView {
    private lazy var stackView = UIStackView()
    var phone: String = "88005553535"

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
        backgroundColor = .systemGray6

        stackView.axis = .vertical
        stackView.distribution = .fill


        phoneTextField.placeholder = "Введите номер телефона"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.borderStyle = .roundedRect


        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect


        stackView.addArrangedSubview(phoneTextField)
        stackView.addArrangedSubview(passwordTextField)


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

        addSubview(stackView)
        addSubview(loginButton)
        addSubview(signupButton)
    }


    override func setupConstraints() {
        super.setupConstraints()

        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            //loginButton.centerXAnchor.constraint(equalTo: superview!.centerXAnchor),
            //loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)

            stackView.topAnchor.constraint(equalTo: margins.topAnchor, constant: self.bounds.height/3.5),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor,constant: 16.0),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor,constant: -16.0),
//
            loginButton.heightAnchor.constraint(equalToConstant: 40.0),
            loginButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2),
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.0),
            loginButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),

            signupButton.heightAnchor.constraint(equalToConstant: 40),
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10.0),
            signupButton.widthAnchor.constraint(equalToConstant: self.bounds.width/2),
            signupButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor)

        ])

//        addSubview(stackView)
//        addSubview(loginButton)
//        addSubview(signupButton)
//        stackView.distribution = .equalCentering
//
//        signupButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50).isActive = true
//
//        loginButton.leading(90)
//        loginButton.trailing(-90)
//        loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
//
//        signupButton.leading(90)
//        signupButton.trailing(-90)
//
//        stackView.top(350)
//        stackView.leading(16)
//        stackView.trailing(-16)




//        stackView.pins(UIEdgeInsets(top: 300.0, left: 16.0, bottom: -350.0, right: -16.0))
    }

    @objc
    private func onTapLogin() {

        phone = phoneTextField.text ?? "88005553535"
        let user = User(phone: phone)
        saveUser(currentUser: user)
        onTapLoginButton?()
    }

    @objc
    private func onTapSignup() {
        onTapSignupButton?()
    }
}