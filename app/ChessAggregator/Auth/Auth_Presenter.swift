
class Auth_Presenter: Auth_PresenterProtocol {
    weak var view: Auth_ViewProtocol!
    var router: Auth_RouterProtocol!
    var interactor: Auth_InteractorProtocol!

    required init(view: Auth_ViewProtocol) {
        self.view = view
    }

    func configureView() {
        // Пока что только простой набросок авторизации
    }

    func didTapSignup() {
        router.showSignup()
    }

    func didTapLogin() {
        let phone = view.authView.phone
        router.showTournaments(withId: phone)
    }
}
