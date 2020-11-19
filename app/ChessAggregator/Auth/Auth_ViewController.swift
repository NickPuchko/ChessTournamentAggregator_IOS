import UIKit
import FirebaseDatabase

class Auth_ViewController: UIViewController, Auth_ViewProtocol {

    let ref: DatabaseReference!
    var presenter: Auth_PresenterProtocol!
    let configurator: Auth_ConfiguratorProtocol!

    var authView: AuthView {
        // Пока не решён вопрос, через что авторизовывается юзер. С одной стороны, нужен номер телефона, потому что
        // подавать заявку на участие в турнире может только верифицированным по номеру пользователь. С другой,
        // с точки зрения бизнес-логики должен быть вариант авторизации без номера телефона, потому что агрегатор так
        // или иначе не сможет существовать без вэб-версии. Какая из зол меньшая?
        view as! AuthView
    }

    required init(ref: DatabaseReference) {
        self.ref = ref
        self.configurator = Auth_Configurator()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = AuthView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        presenter.configureView()

        title = "Вход"

        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapDone))
        //TODO: skip login button

        authView.onTapLoginButton = { [weak self] in
            saveUser(currentUser: User())
            self?.presenter.didTapLogin()
        }

        authView.onTapSignupButton = { [weak self] in
            self?.presenter.didTapSignup()
        }

    }

    @objc
    func didTapDone() {

    }
}