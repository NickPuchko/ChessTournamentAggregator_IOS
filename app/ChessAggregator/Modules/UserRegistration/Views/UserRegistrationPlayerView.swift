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
    var selectedSex: String?
    var sexList: [String] = SexTypes.allCases.map{ $0.rawValue }

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
                                   String?, String?, Bool, String?, String?, Date) -> Void)?

    init() {
        super.init(frame: .zero)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(scrollableStackView)

        setupRoundedTextField(textField: lastName, textFieldPlaceholder: "Фамилия*")
        self.lastNameWarning.text = "Пустое поле. Введите свою фамилию"
        self.scrollableStackView.addArrangedSubview(lastNameStackView)

        setupRoundedTextField(textField: firstName, textFieldPlaceholder: "Имя*")
        self.firstNameWarning.text = "Пустое поле. Введите свое имя"
        self.scrollableStackView.addArrangedSubview(firstNameStackView)

        setupRoundedTextField(textField: patronymicName, textFieldPlaceholder: "Отчество")
        self.scrollableStackView.addArrangedSubview(patronymicName)

        setupRoundedTextField(textField: sex, textFieldPlaceholder: "Пол")
        self.sexPicker.translatesAutoresizingMaskIntoConstraints = false
        self.sex.inputView = sexPicker
        self.sex.autocorrectionType = .no
        self.scrollableStackView.addArrangedSubview(sex)

        setupRoundedTextField(
                textField: emailAddress,
                textFieldPlaceholder: "Введите Ваш email*",
                textFieldKeyboard: .emailAddress
        )
        emailAddressWarning.text = "Адрес почты недействителен. Введите его в формате email@example.com"
        self.emailAddressStackView.addArrangedSubview(emailWasRegisteredWarning)
        self.scrollableStackView.addArrangedSubview(emailAddressStackView)

        setupRoundedTextField(
                textField: fideID,
                textFieldPlaceholder: "FideID",
                textFieldKeyboard: UIKeyboardType.numberPad
        )
        self.fideID.rightView = fideIDButton
        self.fideID.rightViewMode = .always
        self.fideIDButton.addTarget(self, action: #selector(onTapFide), for: .touchUpInside)
        self.scrollableStackView.addArrangedSubview(fideID)

        setupRoundedTextField(textField: frcID, textFieldPlaceholder: "ФШР ID", textFieldKeyboard: .numberPad)
        self.frcID.rightView = frcIDButton
        self.frcID.rightViewMode = .always
        self.frcIDButton.addTarget(self, action: #selector(onTapFrc), for: .touchUpInside)
        self.scrollableStackView.addArrangedSubview(frcID)

        setupRoundedTextField(textField: password, textFieldPlaceholder: "Пароль*")
        self.password.isSecureTextEntry = true
        self.passwordWarning.text = "Пароль недействителен. Он должен содержать 1 Большую букву, 1 маленькую и 1 цифру"
        self.scrollableStackView.addArrangedSubview(passwordStackView)

        setupRoundedTextField(textField: validatePassword, textFieldPlaceholder: "Подтверждение пароля*")
        self.validatePassword.isSecureTextEntry = true
        self.validatePasswordWarning.text = "Пароли не совпадают."
        self.scrollableStackView.addArrangedSubview(validatePasswordStackView)

        self.birthdateStackView.axis = .horizontal
        self.birthdateStackView.distribution = .equalSpacing
        self.birthdateStackView.alignment = .fill

        self.birthdateLabel.attributedText = buildStringWithColoredAsterisk(string: "Дата рождения*")

        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.year = -150
        let minDate = calendar.date(byAdding: components, to: Date())
        let maxDate = Date()
        self.birthdateDatePicker.datePickerMode = .date
        self.birthdateDatePicker.maximumDate = maxDate
        self.birthdateDatePicker.minimumDate = minDate
        self.birthdateDatePicker.locale = Locale(identifier: "ru_RU")

        self.birthdateStackView.addArrangedSubview(birthdateLabel)
        self.birthdateStackView.addArrangedSubview(birthdateDatePicker)

        self.scrollableStackView.addArrangedSubview(birthdateStackView)

        self.registrationButton.setTitle("Зарегистрироваться", for: .normal)
        self.registrationButton.backgroundColor = .black
        self.registrationButton.setTitleColor(.white, for: .normal)
        self.registrationButton.layer.cornerRadius = 10.0
        self.registrationButton.clipsToBounds = false
        self.registrationButton.addTarget(self, action: #selector(onTapRegistration), for: .touchUpInside)

        self.scrollableStackView.addSubview(registrationButton)

        self.switchToOrganizerStackView.axis = .horizontal
        self.switchToOrganizerStackView.distribution = .equalSpacing
        self.switchToOrganizerStackView.alignment = .fill

        self.switchToOrganizerLabel.text = "Вы организатор?"

        self.switchToOrganizerStackView.addArrangedSubview(switchToOrganizerLabel)
        self.switchToOrganizerStackView.addArrangedSubview(switchToOrganizer)

        self.scrollableStackView.addSubview(switchToOrganizerStackView)

        setupRoundedTextField(textField: organizationCity, textFieldPlaceholder: "Город")
        self.organizationCity.isHidden = true
        self.scrollableStackView.addArrangedSubview(self.organizationCity)

        self.organizationNameStackView.axis = .vertical
        self.organizationNameStackView.distribution = .fill
        self.organizationNameStackView.alignment = .fill
        setupRoundedTextField(textField: organizationName, textFieldPlaceholder: "Название организации*")
        self.organizationNameWarning.text = "Поле названия организации пустое. Пожалуйста, заполните его"
        self.organizationNameStackView.addArrangedSubview(organizationName)
        self.organizationNameStackView.addArrangedSubview(organizationNameWarning)
        self.organizationName.isHidden = true
        self.scrollableStackView.addArrangedSubview(self.organizationNameStackView)

        self.switchToOrganizer.addTarget(self, action: #selector(onTapSwitchToOrganizer), for: .touchUpInside)
    }

    override func setupConstraints() {
        super.setupConstraints()

        self.scrollableStackView.pins()

        let margins = self.layoutMarginsGuide
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

        self.scrollableStackView.set(contentInset: UIEdgeInsets(top: 0, left: 0, bottom: registrationOffset, right: 0))

    }


    @objc private func onTapSwitchToOrganizer() {
        self.scrollableStackView.set(contentInset:
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
        self.onTapRegistrationButton?(
                self.lastName.text, self.firstName.text, self.patronymicName.text, self.fideID.text,
                self.frcID.text, self.emailAddress.text, self.password.text, self.validatePassword.text,
                self.switchToOrganizer.isOn, self.organizationCity.text, self.organizationName.text,
                self.birthdateDatePicker.date)
    }

    @objc private func onTapFide() {
        self.onTapFideButton?()
    }

    @objc private func onTapFrc() {
        self.onTapFrcButton?()
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

enum SexTypes: String, CaseIterable {
    case male, female
}