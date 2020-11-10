//
// Created by Иван Лизогуб on 09.11.2020.
//

import Foundation

class NumberRegistrationPresenter: NumberRegistrationPresenterProtocol {

    weak var view: NumberRegistrationViewProtocol!
    var interactor: NumberRegistrationInteractorProtocol!
    var router: NumberRegistrationRouterProtocol!

    required init(view: NumberRegistrationViewProtocol) {
        self.view = view
    }

    func didTapNextButton(withInsertedPhoneNumber insertedPhoneNumber: String?) {
        if let number = insertedPhoneNumber {
            if interactor.isNotInDataBase(phoneNumber: number) {
                router.showNextRegistrationField(phoneNumber: number)
            } else {
                view.showNumberWasRegisteredWarning()
            }
        } else {
            return
        }
    }

    func didTapFlag() {
        router.showFPNCountryList()
    }

    func isPhoneNumberValid(withPhoneNumber phoneNumber: String?, isValid: Bool) -> Bool {
        if let _ = phoneNumber, isValid {
            return true
        } else {
            return false
        }
    }
}