//
// Created by Иван Лизогуб on 05.11.2020.
//
let __firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex = __firstpart + "@" + __serverpart + "[A-Za-z]{2,8}"
let __emailPredicate = NSPredicate(format: "SELF MATCHES %@", __emailRegex)


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
        }
        return true
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

    func validateAll(email: String?, password: String?, passwordValidation: String?,lastName: String?,
                     firstName: String?, OrganisationName: String?, birthdate: Date) {

        if emailValidation(with: email) && isPasswordValid(with: password, validation: passwordValidation) &&
                   firstNameIsNotEmpty(with: firstName) && lastNameIsNotEmpty(with: lastName) &&
                   organisationNameIsNotEmpty(with: OrganisationName) {
            interactor.addUserToDataBase()
            router.goToTournamentsWindow(withPhoneNumber: interactor.getPhoneNumber())
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

    func getFullName() -> String {
         view.getFullName()
    }

    func getBirthdate() -> Date {
         view.getBirthdate()
    }

    func getEloRating() -> Int? {
        view.getEloRating()
    }
}

