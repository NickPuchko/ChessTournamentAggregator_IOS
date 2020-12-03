//
// Created by Иван Лизогуб on 18.11.2020.
//

import FirebaseAuth

class AuthInteractor {
    weak var output: AuthInteractorOutput?

}

extension AuthInteractor: AuthInteractorInput {
    func signIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }

        }
    }


}