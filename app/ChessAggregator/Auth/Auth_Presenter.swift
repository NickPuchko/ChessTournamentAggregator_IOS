//
// Created by Administrator on 05.11.2020.
//

import Foundation

class Auth_Presenter: Auth_PresenterProtocol {
    weak var view: Auth_ViewProtocol!
    var router: Auth_RouterProtocol!
    var interactor: Auth_InteractorProtocol!

    required init(view: Auth_ViewProtocol) {
        self.view = view
    }

    func configureView() {

    }

    func didTapSignup() {
        router.showSignup()
        //TODO: Сделать ссылку на регистрацию
    }

    func didTapLogin() {
        router.showTournaments()
    }
}
