//
// Created by Иван Лизогуб on 05.11.2020.
//

import Foundation

protocol RegistrationConfiguratorProtocol: class {
    func configure(with viewController: RegistrationViewController, andSend phoneNumber: String)
}

protocol RegistrationInteractorProtocol: class {
    func addUserToDataBase()
    func getPhoneNumber() -> String
}

protocol RegistrationPresenterProtocol: class {
    func configureView()
    func emailValidation(with emailAddress: String?) -> Bool
    func isPasswordValid(with password: String?, validation: String?) -> Bool
    func lastNameIsNotEmpty(with lastName: String?) -> Bool
    func firstNameIsNotEmpty(with firstName: String?) -> Bool
    func birthdateIsNotEmpty() -> Bool
    func organisationNameIsNotEmpty(with OrganisationName: String?) -> Bool
    func validateAll(email: String?, password: String?, passwordValidation: String?,
                     lastName: String?, firstName: String?, OrganisationName: String?, birthdate: Date)

    func getFullName() -> String
    func getBirthdate() -> Date
    func getEloRating() -> Int?
}

protocol RegistrationRouterProtocol: class {
    func goToTournamentsWindow(withPhoneNumber phoneNumber: String)
}

protocol RegistrationViewProtocol: class {
    func showEmailWarning()
    func showPasswordWarning()
    func showLastNameWarning()
    func showFirstNameWarning()
    func showBirthdateWarning()
    func showOrganisationNameWarning()

    func getFullName() -> String
    func getBirthdate() -> Date
    func getEloRating() -> Int?
}

