//
//  UserProfileProtocols.swift
//  ChessAggregator
//
//  Created by Иван Лизогуб on 23.11.2020.
//  
//

import Foundation

protocol UserProfileModuleInput {
	var moduleOutput: UserProfileModuleOutput? { get }
}

protocol UserProfileModuleOutput: class {
}

protocol UserProfileViewInput: class {
}

protocol UserProfileViewOutput: class {
	func getUserInformation() -> User
	func editProfile()
	func createEvent()
	func showMyEvents()
	func showStatistics()
	func showFIDE()
	func showFRC()
}

protocol UserProfileInteractorInput: class {
	func loadUser() -> User
	func getUserInformation() -> User
}

protocol UserProfileInteractorOutput: class {
}

protocol UserProfileRouterInput: class {
	func showEditor()
	func showCreator()
	func showMyEvents()
	func showStatistics()
	func showFIDE(user: User)
	func showFRC(user: User)
}
