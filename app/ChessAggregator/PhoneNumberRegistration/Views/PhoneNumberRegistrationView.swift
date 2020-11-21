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
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {

        self.backgroundColor = .systemGray6

        self.nextButton.setTitle("Далее", for: .normal)
        self.nextButton.backgroundColor = .black
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.layer.cornerRadius = 20.0
        self.nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        self.addSubview(nextButton)

        self.numberSectionStack.axis = .vertical
        self.numberSectionStack.alignment = .fill
        self.numberSectionStack.distribution = .fill

        self.yourNumberLabel.text = "Какой ваш номер телефона?"
        self.yourNumberLabel.textColor = .black
        self.yourNumberLabel.font = .boldSystemFont(ofSize: 20)

        self.numberFPNTextField.keyboardType = .numberPad
        self.numberFPNTextField.borderStyle = .roundedRect
        self.numberFPNTextField.displayMode = .list
        self.numberFPNTextField.text = defaultNumber

        self.listController.setup(repository: numberFPNTextField.countryRepository)
        self.listController.didSelect = {[weak self] country in
            self?.numberFPNTextField.setFlag(countryCode: country.code)
        }

        self.numberWasRegisteredLabel.text = "Этот номер уже используется."

        self.numberSectionStack.addArrangedSubview(yourNumberLabel)
        self.numberSectionStack.addArrangedSubview(numberFPNTextField)
        self.numberSectionStack.addArrangedSubview(numberWasRegisteredLabel)

        self.addSubview(numberSectionStack)

        self.nextButton.setTitle("Далее", for: .normal)
        self.nextButton.backgroundColor = .black
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.layer.cornerRadius = 20.0
        self.nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        self.addSubview(nextButton)

    }

    override func setupConstraints() {
        super.setupConstraints()

        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            numberFPNTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            numberSectionStack.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20.0),
            numberSectionStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0),
            numberSectionStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0),

            nextButton.topAnchor.constraint(
                    equalTo: self.numberSectionStack.bottomAnchor,
                    constant: 20.0
            ),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.widthAnchor.constraint(equalToConstant: 150.0),
            nextButton.centerXAnchor.constraint(equalTo: self.numberSectionStack.centerXAnchor)
        ])
    }

    @objc private func onTapNext() {
        let phoneNumber = self.numberFPNTextField.getFormattedPhoneNumber(format: .International)
        self.onTapNextButton?(phoneNumber)
    }
}

