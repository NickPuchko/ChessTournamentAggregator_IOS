//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation

protocol UserRegistrationModuleInput: class {
    var moduleOutput: UserRegistrationModuleOutput? { get }
}

protocol UserRegistrationModuleOutput: class {

}

protocol UserRegistrationViewInput: class {
    func showLastNameWarning()
    func hideLastNameWarning()
    func showFirstNameWarning()
    func hideFirstNameWarning()
    func showEmailWarning()
    func hideEmailWarning()
    func showPasswordWarning()
    func hidePasswordWarning()
    func showValidatePasswordWarning()
    func hideValidatePasswordWarning()
}

protocol UserRegistrationViewOutput: class {
    func onTapRegistration(lastName: String?, firstName: String?, patronymicName: String?,
        ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
        organisationCity: String?, organisationName: String?, birthdate: Date)

}

protocol UserRegistrationInteractorInput: class {
    func addToDataBase(user: UserReg)
}

protocol UserRegistrationInteractorOutput: class {

}

protocol UserRegistrationRouterInput: class {

}