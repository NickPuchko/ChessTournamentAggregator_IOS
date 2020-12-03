//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation

class AuthPresenter {
    weak var view: AuthViewInput?
    weak var moduleOutput: AuthModuleOutput?

    private let router: AuthRouterInput
    private let interactor: AuthInteractorInput

    init(router: AuthRouterInput, interactor: AuthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthModuleInput {

}

extension AuthPresenter: AuthViewOutput {
    
    func onTapLogin(email: String, password: String) {
        moduleOutput?.setPhoneNumber(phoneNumber: "88005553535")
        moduleOutput?.didLogin()
//        interactor.
    }


    func onTapSignUp() {
//        router.showPhoneSignUp()
        moduleOutput?.showPhoneSignUp()
    }
}

extension AuthPresenter: AuthInteractorOutput {

}
