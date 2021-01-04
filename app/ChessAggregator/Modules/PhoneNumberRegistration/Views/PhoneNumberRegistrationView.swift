//
// Created by Иван Лизогуб on 19.11.2020.
//

import UIKit
import FlagPhoneNumber

class PhoneNumberRegistrationView: AutoLayoutView {

    private var defaultNumber = "2 22 22 22 22"

    private let textFieldHeight: CGFloat = 50.0

    private let numberSectionStack = UIStackView()
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    let numberFPNTextField = FPNTextField()
    private let yourNumberLabel = UILabel()
    let numberWasRegisteredLabel = WarningLabel()

    let nextButton = UIButton()
    var onTapNextButton: ((String?) -> Void)?

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        backgroundColor = .systemGray6

        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        addSubview(nextButton)

        numberSectionStack.axis = .vertical
        numberSectionStack.alignment = .fill
        numberSectionStack.distribution = .fill

        yourNumberLabel.text = "Какой ваш номер телефона?"
        yourNumberLabel.textColor = .black
        yourNumberLabel.font = .boldSystemFont(ofSize: 20)

        numberFPNTextField.keyboardType = .numberPad
        numberFPNTextField.borderStyle = .roundedRect
        numberFPNTextField.displayMode = .list
        numberFPNTextField.text = defaultNumber

        listController.setup(repository: numberFPNTextField.countryRepository)
        listController.didSelect = {[weak self] country in
            self?.numberFPNTextField.setFlag(countryCode: country.code)
        }

        numberWasRegisteredLabel.text = "Этот номер уже используется."

        numberSectionStack.addArrangedSubview(yourNumberLabel)
        numberSectionStack.addArrangedSubview(numberFPNTextField)
        numberSectionStack.addArrangedSubview(numberWasRegisteredLabel)

        addSubview(numberSectionStack)

        nextButton.setTitle("Далее", for: .normal)
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        addSubview(nextButton)

    }

    override func setupConstraints() {
        super.setupConstraints()

        let margins = layoutMarginsGuide
        NSLayoutConstraint.activate([
            numberFPNTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            numberSectionStack.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20.0),
            numberSectionStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0),
            numberSectionStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0),

            nextButton.topAnchor.constraint(
                    equalTo: numberSectionStack.bottomAnchor,
                    constant: 20.0
            ),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 150.0),
            nextButton.centerXAnchor.constraint(equalTo: numberSectionStack.centerXAnchor)
        ])
    }

    @objc private func onTapNext() {
        let phoneNumber = numberFPNTextField.getFormattedPhoneNumber(format: .International)
        onTapNextButton?(phoneNumber)
    }
}

