//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation


class UserRegistrationPresenter {
    weak var view: UserRegistrationViewInput?
    weak var moduleOutput: UserRegistrationModuleOutput?

    private let interactor: UserRegistrationInteractorInput
    private let router: UserRegistrationRouterInput

    init(router: UserRegistrationRouterInput, interactor: UserRegistrationInteractorInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension UserRegistrationPresenter: UserRegistrationModuleInput {

}

extension UserRegistrationPresenter: UserRegistrationViewOutput {
    func onTapRegistration(
            lastName: String?, firstName: String?, patronymicName: String?,
            FideID: String?, CFRID: String?, email: String?, password: String?, passwordValidation: String?,
            isOrganizer: Bool, organizationCity: String?, organizationName: String?, birthdate: Date
    ) {

        let user = UserReg(
                lastName: lastName, firstName: firstName, patronymicName: patronymicName,
                FideID: FideID, CFRID: CFRID, email: email, password: password, passwordValidation: passwordValidation,
                isOrganizer: isOrganizer, organisationCity: organizationCity, organisationName: organizationName,
                birthdate: birthdate
        )
        if isUserValid(with: user) {
            interactor.addToDataBase(user: user)
            moduleOutput?.didRegister()
        } else {
            showWarnings(user: user)
        }
    }
}

extension UserRegistrationPresenter: UserRegistrationInteractorOutput {

}

private extension UserRegistrationPresenter {
    func isUserValid(with user: UserReg) -> Bool {
        isLastNameValid(with: user.lastName) &&
                isEmailValid(with: user.email) &&
                isFirstNameValid(with: user.firstName) &&
                isPasswordValid(with: user.password) &&
                isOrganizerValid(with: user.isOrganizer, user.organisationName, user.organisationCity)
    }

    func isEmailValid(with emailAddress: String?) -> Bool {
        if let email = emailAddress {
            return email.isEmail()
        } else {
            return false
        }
    }

    func isLastNameValid(with lastName: String?) -> Bool {
        isStringNotEmpty(string: lastName)
    }

    func isFirstNameValid(with firstName: String?) -> Bool {
        isStringNotEmpty(string: firstName)
    }

    func isBirthdateValid() -> Bool {
        true
    }

    func isPasswordValid(with password: String?) -> Bool {
        guard let pas = password else { return false }
        return pas.isPassword()
    }

    func isValidationPasswordValid(with password: String?, validationPassword: String?) -> Bool {
        guard let pas = password, let val = validationPassword else { return false }
        if pas == val {
            return true
        } else {
            return false
        }
    }
    
    func isOrganizerValid(with isOrganizer: Bool, _ organizationName: String?, _ organizationCity: String?) -> Bool{
        if isOrganizer {
            return isOrganisationNameValid(with: organizationName)
        } else {
            return true
        }
    }

    func isOrganisationNameValid(with OrganisationName: String?) -> Bool {
        isStringNotEmpty(string: OrganisationName)
    }
}

private extension UserRegistrationPresenter {
    func showWarnings(user: UserReg) {
        if isLastNameValid(with: user.lastName) {
            view?.showLastNameWarning(isHidden: true)
        } else {
            view?.showLastNameWarning(isHidden: false)
        }
        if isFirstNameValid(with: user.firstName) {
            view?.showFirstNameWarning(isHidden: true)
        } else {
            view?.showFirstNameWarning(isHidden: false)
        }
        if isEmailValid(with: user.email) {
            view?.showEmailWarning(isHidden: true)
        } else {
            view?.showEmailWarning(isHidden: false)
        }
        if isPasswordValid(with: user.password) {
            view?.showPasswordWarning(isHidden: true)
        } else {
            view?.showPasswordWarning(isHidden: false)
        }
        if isValidationPasswordValid(with: user.password, validationPassword: user.passwordValidation) {
            view?.showValidatePasswordWarning(isHidden: true)
        } else {
            view?.showValidatePasswordWarning(isHidden: false)
        }
        if isOrganizerValid(with: user.isOrganizer, user.organisationName, user.organisationCity) {
            view?.showOrganizationNameWarning(isHidden: true)
        } else {
            view?.showOrganizationNameWarning(isHidden: false)
        }
    }
}

private extension UserRegistrationPresenter {

    func isStringNotEmpty(string: String?) -> Bool {
        guard let str = string else { return false }
        if str.isEmpty {
            return false
        } else {
            return true
        }
    }
}