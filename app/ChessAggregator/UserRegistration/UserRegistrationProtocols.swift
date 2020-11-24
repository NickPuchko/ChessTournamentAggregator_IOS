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
    func showLastNameWarning(isHidden: Bool)
    func showFirstNameWarning(isHidden: Bool)
    func showEmailWarning(isHidden: Bool)
    func showPasswordWarning(isHidden: Bool)
    func showValidatePasswordWarning(isHidden: Bool)
    func showOrganizationNameWarning(isHidden: Bool)
}

protocol UserRegistrationViewOutput: class {
    func onTapRegistration(
            lastName: String?, firstName: String?, patronymicName: String?,
            FideID: String?, CFRID: String?, email: String?, password: String?, passwordValidation: String?,
            isOrganizer: Bool, organizationCity: String?, organizationName: String?, birthdate: Date
    )

}

protocol UserRegistrationInteractorInput: class {
    func addToDataBase(user: UserReg)
}

protocol UserRegistrationInteractorOutput: class {

}

protocol UserRegistrationRouterInput: class {

}