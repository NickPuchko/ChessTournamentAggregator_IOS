import Foundation

class NumberRegistrationInteractor: NumberRegistrationInteractorProtocol {
    weak var presenter: NumberRegistrationPresenterProtocol!

    required init(presenter: NumberRegistrationPresenterProtocol) {
        self.presenter = presenter
    }

    func isNotInDataBase(phoneNumber: String) -> Bool {
        //TODO: implement check of the number in database
        return true
    }
}