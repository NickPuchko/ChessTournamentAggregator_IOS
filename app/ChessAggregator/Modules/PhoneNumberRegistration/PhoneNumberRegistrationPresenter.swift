//
//  PhoneNumberRegistrationPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import Foundation

final class PhoneNumberRegistrationPresenter {
	weak var view: PhoneNumberRegistrationViewInput?
    weak var moduleOutput: PhoneNumberRegistrationModuleOutput?
    
	private let router: PhoneNumberRegistrationRouterInput
	private let interactor: PhoneNumberRegistrationInteractorInput
    
    init(router: PhoneNumberRegistrationRouterInput, interactor: PhoneNumberRegistrationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationModuleInput {
}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationViewOutput {
    func onTapFlag() {
        router.showCountryList()
    }

    func onTapNext(withPhoneNumber phoneNumber: String?) {
        if let number = phoneNumber, interactor.isPhoneNumberValid(phoneNumber: number) {
            view?.showWarning(isHidden: true)
//            router.showSignUp(phoneNumber: number)
            moduleOutput?.setRegPhoneNumber(phoneNumber: number)
            moduleOutput?.showSignUp()
        } else {
            view?.showWarning(isHidden: false)
        }
    }

}

extension PhoneNumberRegistrationPresenter: PhoneNumberRegistrationInteractorOutput {
}
