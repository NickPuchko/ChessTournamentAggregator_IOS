//
// Created by Иван Лизогуб on 18.11.2020.
//

import Foundation

protocol AuthModuleInput: class {
    var moduleOutput: AuthModuleOutput? { get }
}

protocol AuthModuleOutput: class {
    func didLogin()
    func setPhoneNumber(phoneNumber: String)
    func showPhoneSignUp()
}

protocol AuthViewInput: class {

}

protocol AuthViewOutput: class {
    func onTapLogin(email: String, password: String)
    func onTapSignUp()
}

protocol AuthInteractorInput: class {
    func signIn(withEmail: String, password: String)
}

protocol AuthInteractorOutput: class {

}

protocol AuthRouterInput: class {
}
