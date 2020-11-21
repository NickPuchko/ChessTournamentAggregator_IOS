//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation


class UserRegistrationPresenter {
    weak var view: UserRegistrationViewInput?
    weak var moduleOutput: UserRegistrationModuleOutput?

    private let interactor: UserRegistrationInteractorInput?
    private let router: UserRegistrationRouterInput?

    init(router: UserRegistrationRouterInput, interactor: UserRegistrationInteractorInput) {
        self.interactor = interactor
        self.router = router
    }
}

extension UserRegistrationPresenter: UserRegistrationModuleInput {

}

extension UserRegistrationPresenter: UserRegistrationViewOutput {
    func onTapRegistration(lastName: String?, firstName: String?, patronymicName: String?,
                           ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
                           organisationCity: String?, organisationName: String?, birthdate: Date) {

        let user = UserReg(lastName: lastName, firstName: firstName, patronymicName: patronymicName,
                ratingELO: ratingELO, email: email, password: password, passwordValidation: passwordValidation,
                organisationCity: organisationCity, organisationName: organisationName, birthdate: birthdate)
        if isUserValid(with: user) {
            interactor?.addToDataBase(user: user)
            //TODO: ask how to push appCoordinator here
//            moduleOutput?.didLogin()
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
                isPasswordValid(with: user.password)
    }

    func isEmailValid(with emailAddress: String?) -> Bool {
        if let email = emailAddress {
            return email.isEmail()
        } else {
            self.view?.showEmailWarning()
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

    func isOrganisationNameValid(with OrganisationName: String?) -> Bool {
        isStringNotEmpty(string: OrganisationName)
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
}

private extension UserRegistrationPresenter {
    func showWarnings(user: UserReg) {
        if isLastNameValid(with: user.lastName) {
            view?.hideLastNameWarning()
        } else {
            view?.showLastNameWarning()
        }
        if isFirstNameValid(with: user.firstName) {
            view?.showFirstNameWarning()
        } else {

        }
        if isEmailValid(with: user.email) {
            view?.hideEmailWarning()
        } else {
            view?.showEmailWarning()
        }
        if isPasswordValid(with: user.password) {
            view?.hidePasswordWarning()
        } else {
            view?.showPasswordWarning()
        }
        if isValidationPasswordValid(with: user.password, validationPassword: user.passwordValidation) {
            view?.hideValidatePasswordWarning()
        } else {
            view?.showValidatePasswordWarning()
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