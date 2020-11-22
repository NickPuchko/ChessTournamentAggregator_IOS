import Foundation

protocol NumberRegistrationConfiguratorProtocol: class {
    func configure(with viewController: NumberRegistrationViewController)
}

protocol NumberRegistrationInteractorProtocol: class {
    func isNotInDataBase(phoneNumber: String) -> Bool
}

protocol NumberRegistrationPresenterProtocol: class {
    func didTapNextButton(withInsertedPhoneNumber insertedPhoneNumber: String?)
    func didTapFlag()
    func isPhoneNumberValid(withPhoneNumber phoneNumber: String?, isValid: Bool) -> Bool
}

protocol NumberRegistrationRouterProtocol: class {
    func showNextRegistrationField(phoneNumber: String)
    func showFPNCountryList()
}

protocol NumberRegistrationViewProtocol: class {
    func showNumberWasRegisteredWarning()
}