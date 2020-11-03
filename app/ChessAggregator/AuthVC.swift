import UIKit

class AuthVC: UIViewController {

    private var authView: AuthView {
        self.view as! AuthView
    }
    
    override func loadView() {
        self.view = AuthView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Авторизация"
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))

        authView.onTapLoginButton = { [weak self] in
            let alert = UIAlertController(title: "Мы вошли!", message: "На самом деле нет. Ждём Firebase", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ну ладно", style: .default, handler: { _ in  NSLog("Enter alert occurred")}))
            self?.present(alert, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    @objc
    private func didTapDone() {
        navigationController?.pushViewController(TournamentsVC(), animated: true)
    }
}



class AuthView: AutoLayoutView {
    private let stackView = UIStackView()

    let phoneTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(type: .system)
    
    var onTapLoginButton: (() -> Void)?
    
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

        passwordTextField.placeholder = "Введите пароль"
//        phoneTextField.attributedPlaceholder = NSAttributedString(string: "Введите номер телефона", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
//        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.clipsToBounds = false
        loginButton.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)


        stackView.addArrangedSubview(phoneTextField)
        //stackView.setCustomSpacing(16, after: phoneTextField)
        
        stackView.addArrangedSubview(passwordTextField)
        stackView.setCustomSpacing(24, after: passwordTextField)

        stackView.addArrangedSubview(loginButton)

    }
    
    override func setupConstraints() {
        super.setupConstraints()

        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 42).isActive = true

        loginButton.horizontal(80, trailing: -80)

        addSubview(stackView)
        stackView.distribution = .equalCentering


//        stackView.topAnchor.constraint(equalTo: superview!.topAnchor, constant: 300).isActive = true
//        stackView.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -300).isActive = true

        self.stackView.pins(UIEdgeInsets(top: 300.0, left: 16.0, bottom: -350.0, right: -16.0))
    }
    
    
    @objc
    private func onTapLogin() {
        print("tap")
        onTapLoginButton?()
    }

    
}
