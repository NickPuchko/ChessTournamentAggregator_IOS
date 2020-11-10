//
// Created by Иван Лизогуб on 05.11.2020.
//

import Foundation
import UIKit
import Firebase

class RegistrationViewController: UIViewController, RegistrationViewProtocol {

    var presenter: RegistrationPresenterProtocol!
    let configurator: RegistrationConfiguratorProtocol

    let phoneNumber: String
    let ref: DatabaseReference!

    private let scrollableStackView: ScrollableStackView = {
        var result: ScrollableStackView
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .equalCentering,
                        alignment: .fill, spacing: 20.0),
                scroll: .defaultVertical
        )
        result = ScrollableStackView(config: config)
        result.set(contentInset: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0))
        return result
    }()

    private let textFieldHeight: CGFloat = 40.0
    private let lastName = UITextField()
    private let firstName = UITextField()
    private let patronymicName = UITextField()
    private let ratingELO = UITextField()
    private let emailAddress = UITextField()
    private let password = UITextField()
    private let validatePassword = UITextField()

    private let birthdateStackView = UIStackView()
    private let birthdateLabel = UILabel()
    private let birthdateDatePicker = UIDatePicker()

    private let switchToOrganizerStackView = UIStackView()
    private let switchToOrganizer = UISwitch()
    private let switchToOrganizerLabel = UILabel()

    private let organisationCity = UITextField()
    private let organisationName = UITextField()

    private let registrationButton = UIButton(type: .system)


    required init(ref: DatabaseReference, withPhoneNumber phoneNumber: String) {
        self.ref = ref
        self.phoneNumber = phoneNumber
        self.configurator = RegistrationConfigurator()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = scrollableStackView
        self.view.backgroundColor = .white
        title = "Регистрация"
        setup()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self, andSend: phoneNumber)
        presenter.configureView()
    }

    private func setup() {
        setupRoundedTextField(textField: lastName, textFieldPlaceholder: "Фамилия")
        self.scrollableStackView.addArrangedSubview(lastName)

        setupRoundedTextField(textField: firstName, textFieldPlaceholder: "Имя")
        self.scrollableStackView.addArrangedSubview(firstName)

        setupRoundedTextField(textField: patronymicName, textFieldPlaceholder: "Отчество")
        self.scrollableStackView.addArrangedSubview(patronymicName)

        setupRoundedTextField(textField: emailAddress, textFieldPlaceholder: "Введите Ваш email")
        self.scrollableStackView.addArrangedSubview(emailAddress)

        setupRoundedTextField(
                textField: ratingELO,
                textFieldPlaceholder: "Ваш рейтинг ELO",
                textFieldKeyboard: UIKeyboardType.numberPad
        )
        self.scrollableStackView.addArrangedSubview(ratingELO)

        setupRoundedTextField(textField: password, textFieldPlaceholder: "Пароль")
        password.isSecureTextEntry = true
        self.scrollableStackView.addArrangedSubview(password)
        setupRoundedTextField(textField: validatePassword, textFieldPlaceholder: "Подтверждение пароля")
        validatePassword.isSecureTextEntry = true
        self.scrollableStackView.addArrangedSubview(validatePassword)

        birthdateStackView.axis = .horizontal
        birthdateStackView.distribution = .equalSpacing
        birthdateStackView.alignment = .fill

        birthdateLabel.text = "Дата рождения"

        birthdateDatePicker.datePickerMode = .date

        birthdateStackView.addArrangedSubview(birthdateLabel)
        birthdateStackView.addArrangedSubview(birthdateDatePicker)

        self.scrollableStackView.addArrangedSubview(birthdateStackView)

        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.backgroundColor = .black
        registrationButton.setTitleColor(.white, for: .normal)
        registrationButton.layer.cornerRadius = 10.0
        registrationButton.clipsToBounds = false
        registrationButton.addTarget(self, action: #selector(onTapRegistrationButton), for: .touchUpInside)

        self.scrollableStackView.addSubview(registrationButton)

        switchToOrganizerStackView.axis = .horizontal
        switchToOrganizerStackView.distribution = .equalSpacing
        switchToOrganizerStackView.alignment = .fill

        switchToOrganizerLabel.text = "Вы организатор?"

        switchToOrganizerStackView.addArrangedSubview(switchToOrganizerLabel)
        switchToOrganizerStackView.addArrangedSubview(switchToOrganizer)

        self.scrollableStackView.addSubview(switchToOrganizerStackView)

        setupRoundedTextField(textField: organisationCity, textFieldPlaceholder: "Город")
        setupRoundedTextField(textField: organisationName, textFieldPlaceholder: "Название организации")

        self.switchToOrganizer.addTarget(self, action: #selector(didTapSwitchToOrganizer), for: .touchUpInside)

    }

    private func setupConstraints() {

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            lastName.heightAnchor.constraint(equalToConstant: textFieldHeight),
            firstName.heightAnchor.constraint(equalToConstant: textFieldHeight),
            patronymicName.heightAnchor.constraint(equalToConstant: textFieldHeight),

            switchToOrganizerStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            switchToOrganizerStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            switchToOrganizerStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),

            registrationButton.topAnchor.constraint(
                    equalTo: scrollableStackView.contentView.bottomAnchor,
                    constant: 20.0
            ),
            registrationButton.heightAnchor.constraint(equalToConstant: 50.0),
            registrationButton.widthAnchor.constraint(equalToConstant: 200.0),
            registrationButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor)
        ])
    }

    @objc private func onTapRegistrationButton() -> Void {
        presenter.validateAll(
                email: emailAddress.text, password: password.text,
                passwordValidation: validatePassword.text, lastName: lastName.text,
                firstName: firstName.text, OrganisationName: organisationName.text,
                birthdate: birthdateDatePicker.date)
    }

    @objc private func didTapSwitchToOrganizer() {
        if self.switchToOrganizer.isOn {
            self.organisationName.isHidden = false
            self.organisationCity.isHidden = false
            UIView.animate(withDuration: 0.5, delay:0.0, options: [],
                    animations: {
                        self.scrollableStackView.addArrangedSubview(self.organisationCity)
                        self.scrollableStackView.addArrangedSubview(self.organisationName)
                        self.view.layoutIfNeeded()
                    },
                    completion: nil
            )
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [],
                    animations: {
                        self.scrollableStackView.removeArrangedSubview(self.organisationName)
                        self.scrollableStackView.removeArrangedSubview(self.organisationCity)
                        self.view.layoutIfNeeded()
                    },
                    completion: nil
            )
            self.organisationName.isHidden = true
            self.organisationCity.isHidden = true
        }
    }

    func getFullName() -> String {
        var result: String
        result = lastName.text! + " "
        result += firstName.text!
        result += " "
        result += (patronymicName.text ?? "")
        return result
    }

    func getBirthdate() -> Date {
        birthdateDatePicker.date
    }

    func getEloRating() -> Int? {
        guard let stringElo = ratingELO.text else {return nil}
        return Int(stringElo)
    }

    func showEmailWarning() {

    }

    func showPasswordWarning() {
    }

    func showLastNameWarning() {
    }

    func showFirstNameWarning() {
    }

    func showBirthdateWarning() {
    }

    func showOrganisationNameWarning() {
    }

}

extension RegistrationViewController {
    private func setupRoundedTextField(textField: UITextField, textFieldPlaceholder: String,
                                       textFieldKeyboard: UIKeyboardType = .default) {
        textField.placeholder = textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = textFieldKeyboard
    }
}

//extension RegistrationViewController: UITextFieldDelegate {
//
//}