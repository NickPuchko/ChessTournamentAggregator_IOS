import Foundation

protocol RegistrationConfiguratorProtocol: class {
    func configure(with viewController: RegistrationViewController, andSend phoneNumber: String)
}

protocol RegistrationInteractorProtocol: class {
    func getPhoneNumber() -> String
    func addUserToDataBase(lastName: String?, firstName: String?, patronymicName: String?,
                           ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
                           organisationCity: String?, organisationName: String?, birthdate: Date)
}

protocol RegistrationPresenterProtocol: class {
    func configureView()
    func emailValidation(with emailAddress: String?) -> Bool
    func isPasswordValid(with password: String?, validation: String?) -> Bool
    func lastNameIsNotEmpty(with lastName: String?) -> Bool
    func firstNameIsNotEmpty(with firstName: String?) -> Bool
    func birthdateIsNotEmpty() -> Bool
    func organisationNameIsNotEmpty(with OrganisationName: String?) -> Bool
    func addToDatabase(lastName: String?, firstName: String?, patronymicName: String?,
                       ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
                       organisationCity: String?, organisationName: String?, birthdate: Date)

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

}

