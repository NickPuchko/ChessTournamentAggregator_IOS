//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation
import FirebaseAuth

class AuthInteractor {
    weak var output: AuthInteractorOutput?

}

extension AuthInteractor: AuthInteractorInput {
    func forgot() {

    }


    func signIn(withEmail email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .wrongPassword:
                        self?.output?.showError(error: "Неверный логин или пароль")
                    case .invalidEmail:
                        self?.output?.showError(error: "Неправильный формат адреса электронной почты")
                    default:
                        self?.output?.showError(error: "")
                    }
                }
            } else {
                self?.output?.didLogin()
            }
        }
    }
}
