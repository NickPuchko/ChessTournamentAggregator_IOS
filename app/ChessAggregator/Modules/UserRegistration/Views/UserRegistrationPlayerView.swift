//
// Created by Иван Лизогуб on 15.11.2020.
//

import Foundation
import UIKit

class UserRegistrationPlayerView: AutoLayoutView {
    let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                        alignment: .fill, spacing: 20.0),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 20.0, left: 16.0, bottom: 0.0, right: -16.0)
        )
        return ScrollableStackView(config: config)
    }()

    private let textFieldHeight: CGFloat = 40.0
    private let registrationButtonSpacingToContentView: CGFloat = 20.0
    private let registrationButtonHeight: CGFloat = 50.0
    private let switchToOrganizerStackViewHeight: CGFloat = 30.0
    let maxValueOfId = 999999999
    var registrationOffset: CGFloat {
        registrationButtonSpacingToContentView + registrationButtonHeight + switchToOrganizerStackViewHeight
    }


    private lazy var lastNameStackView = buildStackView(withTextField: lastName, andLabel: lastNameWarning)
    let lastName = UITextField()
    let lastNameWarning = WarningLabel()

    private lazy var firstNameStackView = buildStackView(withTextField: firstName, andLabel: firstNameWarning)
    let firstName = UITextField()
    let firstNameWarning = WarningLabel()

    let sex = UITextField()
    let sexPicker = UIPickerView()
    var sexList: [String] = Sex.allCases.map{ $0.rawValue }


    let patronymicName = UITextField()

    let fideID = UITextField()
    private let fideIDButton = UIButton(type: .infoLight)
    var onTapFideButton: (() -> Void)?

    let frcID = UITextField()
    private let frcIDButton = UIButton(type: .infoLight)
    var onTapFrcButton: (() -> Void)?

    private lazy var emailAddressStackView = buildStackView(withTextField: emailAddress, andLabel: emailAddressWarning)
    let emailAddress = UITextField()
    let emailAddressWarning = WarningLabel()
    let emailWasRegisteredWarning = WarningLabel()

    private lazy var passwordStackView = buildStackView(withTextField: password, andLabel: passwordWarning)
    let password = UITextField()
    let passwordWarning = WarningLabel()

    private lazy var validatePasswordStackView = buildStackView(withTextField: validatePassword, andLabel: validatePasswordWarning)
    let validatePassword = UITextField()
    let validatePasswordWarning = WarningLabel()

    private let birthdateStackView = UIStackView()
    private let birthdateLabel = UILabel()
    private let birthdateDatePicker = UIDatePicker()

    private let switchToOrganizerStackView = UIStackView()
    private let switchToOrganizer = UISwitch()
    private let switchToOrganizerLabel = UILabel()

    let organizationCity = UITextField()

    private let organizationNameStackView = UIStackView()
    let organizationName = UITextField()
    let organizationNameWarning = WarningLabel()
    
    private let registrationButton = UIButton(type: .system)
    var onTapRegistrationButton: ((String?, String?, String?, String?, String?, String?,
                                   String?, String?, Bool, String?, String?, Date, String?) -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(scrollableStackView)

        setupRoundedTextField(textField: lastName, textFieldPlaceholder: "Фамилия*")
        lastNameWarning.text = "Пустое поле. Введите свою фамилию"
        scrollableStackView.addArrangedSubview(lastNameStackView)

        setupRoundedTextField(textField: firstName, textFieldPlaceholder: "Имя*")
        firstNameWarning.text = "Пустое поле. Введите свое имя"
        scrollableStackView.addArrangedSubview(firstNameStackView)

        setupRoundedTextField(textField: patronymicName, textFieldPlaceholder: "Отчество")
        scrollableStackView.addArrangedSubview(patronymicName)

        setupRoundedTextField(textField: sex, textFieldPlaceholder: "Пол")
        sexPicker.translatesAutoresizingMaskIntoConstraints = false
        sex.inputView = sexPicker
        sex.autocorrectionType = .no
        scrollableStackView.addArrangedSubview(sex)

        setupRoundedTextField(
                textField: emailAddress,
                textFieldPlaceholder: "Введите Ваш email*",
                textFieldKeyboard: .emailAddress
        )
        emailAddressWarning.text = "Адрес почты недействителен. Введите его в формате email@example.com"
        emailAddressStackView.addArrangedSubview(emailWasRegisteredWarning)
        scrollableStackView.addArrangedSubview(emailAddressStackView)

        setupRoundedTextField(
                textField: fideID,
                textFieldPlaceholder: "FideID",
                textFieldKeyboard: UIKeyboardType.numberPad
        )
        fideID.rightView = fideIDButton
        fideID.rightViewMode = .always
        fideIDButton.addTarget(self, action: #selector(onTapFide), for: .touchUpInside)
        scrollableStackView.addArrangedSubview(fideID)

        setupRoundedTextField(textField: frcID, textFieldPlaceholder: "ФШР ID", textFieldKeyboard: .numberPad)
        frcID.rightView = frcIDButton
        frcID.rightViewMode = .always
        frcIDButton.addTarget(self, action: #selector(onTapFrc), for: .touchUpInside)
        scrollableStackView.addArrangedSubview(frcID)

        setupRoundedTextField(textField: password, textFieldPlaceholder: "Пароль*")
        password.isSecureTextEntry = true
        passwordWarning.text = "Пароль недействителен. Он должен содержать 1 Большую букву, 1 маленькую и 1 цифру"
        scrollableStackView.addArrangedSubview(passwordStackView)

        setupRoundedTextField(textField: validatePassword, textFieldPlaceholder: "Подтверждение пароля*")
        validatePassword.isSecureTextEntry = true
        validatePasswordWarning.text = "Пароли не совпадают."
        scrollableStackView.addArrangedSubview(validatePasswordStackView)

        birthdateStackView.axis = .horizontal
        birthdateStackView.distribution = .equalSpacing
        birthdateStackView.alignment = .fill

        birthdateLabel.attributedText = buildStringWithColoredAsterisk(string: "Дата рождения*")

        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.year = -150
        let minDate = calendar.date(byAdding: components, to: Date())
        let maxDate = Date()
        birthdateDatePicker.datePickerMode = .date
        birthdateDatePicker.maximumDate = maxDate
        birthdateDatePicker.minimumDate = minDate
        birthdateDatePicker.locale = Locale(identifier: "ru_RU")

        birthdateStackView.addArrangedSubview(birthdateLabel)
        birthdateStackView.addArrangedSubview(birthdateDatePicker)

        scrollableStackView.addArrangedSubview(birthdateStackView)

        registrationButton.setTitle("Зарегистрироваться", for: .normal)
        registrationButton.backgroundColor = .black
        registrationButton.setTitleColor(.white, for: .normal)
        registrationButton.layer.cornerRadius = 10.0
        registrationButton.clipsToBounds = true
        registrationButton.addTarget(self, action: #selector(onTapRegistration), for: .touchUpInside)

        scrollableStackView.addSubview(registrationButton)

        switchToOrganizerStackView.axis = .horizontal
        switchToOrganizerStackView.distribution = .equalSpacing
        switchToOrganizerStackView.alignment = .fill

        switchToOrganizerLabel.text = "Вы организатор?"

        switchToOrganizerStackView.addArrangedSubview(switchToOrganizerLabel)
        switchToOrganizerStackView.addArrangedSubview(switchToOrganizer)

        scrollableStackView.addSubview(switchToOrganizerStackView)

        setupRoundedTextField(textField: organizationCity, textFieldPlaceholder: "Город")
        organizationCity.isHidden = true
        scrollableStackView.addArrangedSubview(organizationCity)

        organizationNameStackView.axis = .vertical
        organizationNameStackView.distribution = .fill
        organizationNameStackView.alignment = .fill
        setupRoundedTextField(textField: organizationName, textFieldPlaceholder: "Название организации*")
        organizationNameWarning.text = "Поле названия организации пустое. Пожалуйста, заполните его"
        organizationNameStackView.addArrangedSubview(organizationName)
        organizationNameStackView.addArrangedSubview(organizationNameWarning)
        organizationName.isHidden = true
        scrollableStackView.addArrangedSubview(organizationNameStackView)

        switchToOrganizer.addTarget(self, action: #selector(onTapSwitchToOrganizer), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        scrollableStackView.pins()

        let margins = layoutMarginsGuide

        NSLayoutConstraint.activate([
            switchToOrganizerStackView.heightAnchor.constraint(equalToConstant: switchToOrganizerStackViewHeight),
            switchToOrganizerStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            switchToOrganizerStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            switchToOrganizerStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),

            registrationButton.topAnchor.constraint(
                    equalTo: scrollableStackView.contentView.bottomAnchor,
                    constant: registrationButtonSpacingToContentView
            ),
            registrationButton.heightAnchor.constraint(equalToConstant: registrationButtonHeight),
            registrationButton.widthAnchor.constraint(equalToConstant: 200.0),
            registrationButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor),
        ])

        scrollableStackView.set(contentInset: UIEdgeInsets(top: 0, left: 0, bottom: registrationOffset, right: 0))

    }


    @objc private func onTapSwitchToOrganizer() {
        scrollableStackView.set(contentInset:
        UIEdgeInsets(top: 0.0, left: 0, bottom: registrationOffset, right: 0)
        )
        UIView.animate(withDuration: 0.5, delay:0.0, options: [],
                animations: {
                    self.organizationName.isHidden = !self.switchToOrganizer.isOn
                    self.organizationCity.isHidden = !self.switchToOrganizer.isOn
                    self.organizationNameWarning.isHidden = true
                    self.layoutIfNeeded()
                },
                completion: nil
        )
    }

    @objc private func onTapRegistration() {
        onTapRegistrationButton?(
                lastName.text, firstName.text, patronymicName.text, fideID.text,
                frcID.text, emailAddress.text, password.text, validatePassword.text,
                switchToOrganizer.isOn, organizationCity.text, organizationName.text,
                birthdateDatePicker.date, sex.text)
    }

    @objc private func onTapFide() {
        onTapFideButton?()
    }

    @objc private func onTapFrc() {
        onTapFrcButton?()
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
        let attributedString = buildStringWithColoredAsterisk(string: textFieldPlaceholder)
        textField.attributedPlaceholder = attributedString
        textField.borderStyle = .roundedRect
        textField.keyboardType = textFieldKeyboard
    }

    func buildStringWithColoredAsterisk(string: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString.init(string: string)
        let range = (string as NSString).range(of: "*")
        attributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: Styles.Color.asteriskRed,
                range: range
        )
        return attributedString
    }

}
