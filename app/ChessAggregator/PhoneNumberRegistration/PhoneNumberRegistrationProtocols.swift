//
//  PhoneNumberRegistrationProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 19.11.2020.
//  
//

import Foundation

protocol PhoneNumberRegistrationModuleInput {
	var moduleOutput: PhoneNumberRegistrationModuleOutput? { get }
}

protocol PhoneNumberRegistrationModuleOutput: class {
}

protocol PhoneNumberRegistrationViewInput: class {
	func showWarning()
	func hideWarning()
}

protocol PhoneNumberRegistrationViewOutput: class {
	func onTapNext(withPhoneNumber: String?)
}

protocol PhoneNumberRegistrationInteractorInput: class {
	func isPhoneNumberValid(phoneNumber: String) -> Bool
}

protocol PhoneNumberRegistrationInteractorOutput: class {
}

protocol PhoneNumberRegistrationRouterInput: class {
	func showSignUp(phoneNumber: String)
}
