//
// Created by Иван Лизогуб on 05.11.2020.
//


import Foundation

class RegistrationPresenter: RegistrationPresenterProtocol {

    weak var view: RegistrationViewProtocol!
    var interactor: RegistrationInteractorProtocol!
    var router: RegistrationRouterProtocol!

    required init(view: RegistrationViewProtocol) {
        self.view = view
    }

    func isPasswordValid(with password: String?, validation: String?) -> Bool {
        guard let pas = password, let val = validation else {return false}
        if pas == val {
            return true
        } else {
            return false
        }
    }

    func configureView() {

    }

    func emailValidation(with emailAddress: String?) -> Bool {
        if let email = emailAddress {
            return email.isEmail()
        } else {
            view.showEmailWarning()
            return false
        }
    }

    func lastNameIsNotEmpty(with lastName: String?) -> Bool {
        isStringEmpty(string: lastName)
    }

    func firstNameIsNotEmpty(with firstName: String?) -> Bool {
        isStringEmpty(string: firstName)
    }

    func birthdateIsNotEmpty() -> Bool {
        true
    }

    func organisationNameIsNotEmpty(with OrganisationName: String?) -> Bool {
        isStringEmpty(string: OrganisationName)
    }

    func addToDatabase(lastName: String?, firstName: String?, patronymicName: String?,
                       ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
                       organisationCity: String?, organisationName: String?, birthdate: Date) {

        if firstNameIsNotEmpty(with: firstName) && lastNameIsNotEmpty(with: lastName) &&
                   emailValidation(with: email) && isPasswordValid(with: password, validation: passwordValidation) {

            interactor.addUserToDataBase(lastName: lastName, firstName: firstName, patronymicName: patronymicName,
                    ratingELO: ratingELO, email: email, password: password, passwordValidation: passwordValidation,
                    organisationCity: organisationCity, organisationName: organisationName, birthdate: birthdate)

            router.goToTournamentsWindow(withPhoneNumber: interactor.getPhoneNumber())
        } else {

        }
    }


    private func isStringEmpty(string: String?) -> Bool {
        guard let str = string else {return false}
        if str.isEmpty {
            return false
        } else {
            return true
        }
    }

}

