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
}

protocol AuthViewInput: class {

}

protocol AuthViewOutput: class {
    func onTapLogin()
    func onTapSignUp()
}

protocol AuthInteractorInput: class {
}

protocol AuthInteractorOutput: class {

}

protocol AuthRouterInput: class {
    func showPhoneSignUp()
}
