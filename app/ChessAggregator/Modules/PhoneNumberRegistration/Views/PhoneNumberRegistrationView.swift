//
// Created by Иван Лизогуб on 19.11.2020.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth

class PhoneNumberRegistrationView: AutoLayoutView {
    
    
    var GetButtonTappedOnce : Bool = false
    
    var codeIsRight : Bool = false

    private var defaultNumber = "2 22 22 22 22"
    
    var phoneNumber : String?
    
    var verificationID: String!

    private let textFieldHeight: CGFloat = 50.0

    private let numberSectionStack = UIStackView()
    var listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    let numberFPNTextField = FPNTextField()
    let verificationCodeTextField = AnimatedTextField()
    private let yourNumberLabel = UILabel()
    var isTapped : Bool = false
    let yourCodeLabel = AnimatedLabel()
    let numberWasRegisteredLabel = WarningLabel()
    let verificationWasFailed = WarningLabel()

    let nextButton = UIButton()
    let getCodeButton = UIButton()
    var onTapNextButton: ((String?) -> Void)?
    var onTapGetButton: ((String?) -> Void)?

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
        
        self.getCodeButton.setTitle("Отправить код", for: .normal)
       // self.getCodeButton.alpha = 0.5
        self.getCodeButton.isEnabled = true
        self.getCodeButton.backgroundColor = .black
        self.getCodeButton.setTitleColor(.white, for: .normal)
        self.getCodeButton.layer.cornerRadius = 20.0
        self.getCodeButton.clipsToBounds = false
        getCodeButton.addTarget(self, action: #selector(onTapGet), for: .touchUpInside)
        self.addSubview(getCodeButton)
        
        
        
        
        

        self.numberSectionStack.axis = .vertical
        self.numberSectionStack.alignment = .fill
        self.numberSectionStack.distribution = .fill

        self.yourNumberLabel.text = "Какой ваш номер телефона?"
        self.yourNumberLabel.textColor = .black
        self.yourNumberLabel.font = .boldSystemFont(ofSize: 20)
        
        self.yourCodeLabel.text = "Введите код из СМС-сообщения"
       

        self.numberFPNTextField.keyboardType = .numberPad
        self.numberFPNTextField.borderStyle = .roundedRect
        self.numberFPNTextField.displayMode = .list
        self.numberFPNTextField.text = defaultNumber
        
        self.verificationCodeTextField.keyboardType = .numberPad
        self.verificationCodeTextField.borderStyle = .roundedRect
        self.verificationCodeTextField.isHidden = true

        self.listController.setup(repository: numberFPNTextField.countryRepository)
        self.listController.didSelect = {[weak self] country in
            self?.numberFPNTextField.setFlag(countryCode: country.code)
        }

        self.numberWasRegisteredLabel.text = "Этот номер уже используется."
        self.verificationWasFailed.text = "Ошибка верефикации."

        self.numberSectionStack.addArrangedSubview(yourNumberLabel)
        self.numberSectionStack.addArrangedSubview(numberFPNTextField)
        self.numberSectionStack.addArrangedSubview(numberWasRegisteredLabel)
        self.numberSectionStack.addArrangedSubview(yourCodeLabel)
        self.numberSectionStack.addArrangedSubview(verificationCodeTextField)
        self.numberSectionStack.addArrangedSubview(verificationWasFailed)
       
        
        
        self.addSubview(numberSectionStack)
        

        self.nextButton.setTitle("Далее", for: .normal)
        self.nextButton.backgroundColor = .black
        self.nextButton.setTitleColor(.white, for: .normal)
        self.nextButton.layer.cornerRadius = 20.0
        self.nextButton.alpha = 0
        self.nextButton.isEnabled = false
        self.nextButton.clipsToBounds = false
        nextButton.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        self.addSubview(nextButton)

    }

    override func setupConstraints() {
        super.setupConstraints()

        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            numberFPNTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            verificationCodeTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            numberSectionStack.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20.0),
            numberSectionStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0),
            numberSectionStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0),
            
            
            getCodeButton.topAnchor.constraint(
                equalTo: self.numberSectionStack.bottomAnchor,
                constant: 20.0),
            getCodeButton.centerXAnchor.constraint(equalTo: self.numberSectionStack.centerXAnchor),
            getCodeButton.heightAnchor.constraint(equalToConstant: 50),
            getCodeButton.widthAnchor.constraint(equalToConstant: 200.0),

            nextButton.topAnchor.constraint(
                    equalTo: self.getCodeButton.bottomAnchor,
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
    
    @objc private func onTapGet() {
        let phoneNumber = self.numberFPNTextField.getFormattedPhoneNumber(format: .International)
        self.onTapGetButton?(phoneNumber)
    }
}

