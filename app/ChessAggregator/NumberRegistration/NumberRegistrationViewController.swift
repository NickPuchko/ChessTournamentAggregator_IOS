//
// Created by Иван Лизогуб on 09.11.2020.
//

import UIKit
import FlagPhoneNumber
import Firebase

class NumberRegistrationViewController: UIViewController, NumberRegistrationViewProtocol {

    //TODO: delete this defaultNumber
    private var defaultNumber = "2 22 22 22 22"

    var presenter: NumberRegistrationPresenterProtocol!
    let configurator: NumberRegistrationConfiguratorProtocol

    let ref: DatabaseReference!

    private let scrollableStackView: ScrollableStackView = {
        var config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, spacing: 20.0),
                scroll: .defaultVertical
        )
        let result = ScrollableStackView(config: config)
        result.set(contentInset: UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0))
        return result
    }()

    private let textFieldHeight: CGFloat = 40.0

    private let numberSectionStack = UIStackView()
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    let numberFPNTextField = FPNTextField()
    private let yourNumberLabel = UILabel()

    private let numberWasRegisteredLabel = UILabel()
    private let nextButton = UIButton()

    required init(ref: DatabaseReference) {
        self.ref = ref
        self.configurator = NumberRegistrationConfigurator()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = scrollableStackView
        self.view.backgroundColor = .white
        setup()
        setupConstraints()
        title = "Регистрация"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
    }

    private func setup() {

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
        self.numberFPNTextField.delegate = self

        self.listController.setup(repository: numberFPNTextField.countryRepository)
        self.listController.didSelect = {[weak self] country in
            self?.numberFPNTextField.setFlag(countryCode: country.code)
        }


        self.numberSectionStack.addArrangedSubview(yourNumberLabel)
        self.numberSectionStack.addArrangedSubview(numberFPNTextField)

        self.scrollableStackView.addArrangedSubview(numberSectionStack)

        self.numberWasRegisteredLabel.text = "Этот номер уже используется."
        self.numberWasRegisteredLabel.textColor = .red
        self.numberWasRegisteredLabel.font = .italicSystemFont(ofSize: 15.0)
        self.numberWasRegisteredLabel.isHidden = true

        self.scrollableStackView.addArrangedSubview(numberWasRegisteredLabel)
        self.scrollableStackView.setCustomSpacing(0, after: numberFPNTextField)

        //TODO: delete these default lists
//        if numberFPNTextField.text!.count != 13 {
//            self.nextButton.isEnabled = false
//        } else {
//            self.nextButton.isEnabled = true
//        }
        self.nextButton.setTitle("Далее", for: .normal)
        self.nextButton.backgroundColor = .black
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.layer.cornerRadius = 20.0
        self.nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNextButton), for: .touchUpInside)
        self.view.addSubview(nextButton)
    }

    @objc private func onTapNextButton() {
        let number = numberFPNTextField.getFormattedPhoneNumber(format: .International)
        self.presenter.didTapNextButton(withInsertedPhoneNumber: number)
    }

    private func setupConstraints() {

        NSLayoutConstraint.activate([
            numberFPNTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),

            nextButton.topAnchor.constraint(
                    equalTo: scrollableStackView.contentView.bottomAnchor,
                    constant: 20.0
            ),
            nextButton.heightAnchor.constraint(equalToConstant: 50.0),
            nextButton.widthAnchor.constraint(equalToConstant: 100.0),
            nextButton.centerXAnchor.constraint(equalTo: scrollableStackView.contentView.centerXAnchor)
        ])
    }

    func showNumberWasRegisteredWarning() {
        self.numberWasRegisteredLabel.isHidden = false
    }

    private func hideNumberWasRegisteredWarning() {
        self.numberWasRegisteredLabel.isHidden = true
    }
}

extension NumberRegistrationViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //
    }

    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        hideNumberWasRegisteredWarning()
        if presenter.isPhoneNumberValid(
                withPhoneNumber: textField.getFormattedPhoneNumber(format: .International),
                isValid: isValid
        ) {
//            nextButton.isEnabled = true
        } else {
//            nextButton.isEnabled = false
        }
    }

    func fpnDisplayCountryList() {
        presenter.didTapFlag()
    }


}