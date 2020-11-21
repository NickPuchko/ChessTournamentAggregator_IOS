//
// Created by Иван Лизогуб on 15.11.2020.
//

import Foundation
import UIKit

class UserRegistrationPlayerView: AutoLayoutView {
    private let scrollableStackView: ScrollableStackView = {
        var result: ScrollableStackView
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .equalCentering,
                        alignment: .fill, spacing: 10.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: -16.0)
        )
        result = ScrollableStackView(config: config)
        return result
    }()

    private let textFieldHeight: CGFloat = 40.0

    private var lastNameStackView: UIStackView?
    private let lastName = UITextField()
    let lastNameWarning = WarningLabel()

    private var firstNameStackView: UIStackView?
    private let firstName = UITextField()
    let firstNameWarning = WarningLabel()

    private let patronymicName = UITextField()
    private let ratingELO = UITextField()

    private var emailAddressStackView: UIStackView?
    private let emailAddress = UITextField()
    let emailAddressWarning = WarningLabel()

    private var passwordStackView: UIStackView?
    private let password = UITextField()
    let passwordWarning = WarningLabel()

    private var validatePasswordStackView: UIStackView?
    private let validatePassword = UITextField()
    let validatePasswordWarning = WarningLabel()

    private let birthdateStackView = UIStackView()
    private let birthdateLabel = UILabel()
    private let birthdateDatePicker = UIDatePicker()

    private let switchToOrganizerStackView = UIStackView()
    private let switchToOrganizer = UISwitch()
    private let switchToOrganizerLabel = UILabel()

    private let organisationCity = UITextField()
    private let organisationName = UITextField()
    
    private let registrationButton = UIButton(type: .system)
    var onTapRegistrationButton: ((String?, String?, String?, String?, String?, String?, String?, String?, String?, Date) -> Void)?

    init() {
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(scrollableStackView)

        setupRoundedTextField(textField: lastName, textFieldPlaceholder: "Фамилия")
        lastNameWarning.text = "Пустое поле. Введите свою фамилию"
        self.lastNameStackView = buildStackView(withTextField: lastName, andLabel: lastNameWarning)
        self.scrollableStackView.addArrangedSubview(lastNameStackView!)

        setupRoundedTextField(textField: firstName, textFieldPlaceholder: "Имя")
        firstNameWarning.text = "Пустое поле. Введите свое имя"
        self.firstNameStackView = buildStackView(withTextField: firstName, andLabel: firstNameWarning)
        self.scrollableStackView.addArrangedSubview(firstNameStackView!)

        setupRoundedTextField(textField: patronymicName, textFieldPlaceholder: "Отчество")
        self.scrollableStackView.addArrangedSubview(patronymicName)

        setupRoundedTextField(textField: emailAddress, textFieldPlaceholder: "Введите Ваш email")
        emailAddressWarning.text = "Адрес почты недействителен. Введите его в формате email@example.com"
        self.emailAddressStackView = buildStackView(withTextField: emailAddress, andLabel: emailAddressWarning)
        self.scrollableStackView.addArrangedSubview(emailAddressStackView!)

        setupRoundedTextField(
                textField: ratingELO,
                textFieldPlaceholder: "Ваш рейтинг ELO",
                textFieldKeyboard: UIKeyboardType.numberPad
        )
        self.scrollableStackView.addArrangedSubview(ratingELO)

        setupRoundedTextField(textField: password, textFieldPlaceholder: "Пароль")
        self.password.isSecureTextEntry = true
        self.passwordWarning.text = "Пароль недействителен. Он должен содержать 1 Большую букву, 1 маленькую и 1 цифру"
        self.passwordStackView = buildStackView(withTextField: password, andLabel: passwordWarning)
        self.scrollableStackView.addArrangedSubview(passwordStackView!)
        setupRoundedTextField(textField: validatePassword, textFieldPlaceholder: "Подтверждение пароля")
        self.validatePassword.isSecureTextEntry = true
        self.validatePasswordWarning.text = "Пароли не совпадают."
        self.validatePasswordStackView = buildStackView(
                withTextField: validatePassword,
                andLabel: validatePasswordWarning
        )
        self.scrollableStackView.addArrangedSubview(validatePasswordStackView!)

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
        registrationButton.addTarget(self, action: #selector(onTapRegistration), for: .touchUpInside)

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
        self.organisationCity.isHidden = true
        self.organisationName.isHidden = true

        self.switchToOrganizer.addTarget(self, action: #selector(onTapSwitchToOrganizer), for: .touchUpInside)

        self.scrollableStackView.addArrangedSubview(self.organisationCity)
        self.scrollableStackView.addArrangedSubview(self.organisationName)

    }

    override func setupConstraints() {
        super.setupConstraints()

        self.scrollableStackView.pins()

        let margins = self.layoutMarginsGuide
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
            registrationButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor),
            registrationButton.bottomAnchor.constraint(lessThanOrEqualTo: switchToOrganizerStackView.topAnchor)
        ])
    }


    @objc private func onTapSwitchToOrganizer() {
        UIView.animate(withDuration: 0.5, delay:0.0, options: [],
                animations: {
                    self.organisationName.isHidden = !self.switchToOrganizer.isOn
                    self.organisationCity.isHidden = !self.switchToOrganizer.isOn
                    self.layoutIfNeeded()
                },
                completion: nil
        )
    }

    @objc private func onTapRegistration() {
        self.onTapRegistrationButton?(self.lastName.text, self.firstName.text, self.patronymicName.text,
                self.ratingELO.text, self.emailAddress.text, self.password.text, self.validatePassword.text,
                self.organisationCity.text, self.organisationName.text, self.birthdateDatePicker.date)
    }
}

private extension UserRegistrationPlayerView {

    func buildStackView(withTextField textField: UITextField, andLabel label: UILabel) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(label)
        return stackView
    }

    func setupRoundedTextField(textField: UITextField, textFieldPlaceholder: String,
                                       textFieldKeyboard: UIKeyboardType = .default) {
        textField.placeholder = textFieldPlaceholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = textFieldKeyboard
    }
}