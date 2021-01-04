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
	func updateUser(user: User)
}

protocol UserProfileViewOutput: class {
	func editProfile()
	func createEvent()
	func showMyEvents()
	func showStatistics()
	func showFIDE()
	func showFRC()
}

protocol UserProfileInteractorInput: class {
    //func reloadData()
}

protocol UserProfileInteractorOutput: class {
	func updateUser(user: User)

}

protocol UserProfileRouterInput: class {
	func showEditor(with user: User)
	func showCreator()
	func showMyEvents()
	func showStatistics()
	func showFIDE(user: User)
	func showFRC(user: User)
}
