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
	func updateUser(user: UserViewModel)
}

protocol UserProfileViewOutput: class {
	var userViewModel: UserViewModel? { get }
	func editProfile()
	func createEvent()
	func showFIDE()
	func showFRC()
    func signOut()
}

protocol UserProfileInteractorInput: class {
}

protocol UserProfileInteractorOutput: class {
	func updateUser(user: User)

}

protocol UserProfileRouterInput: class {
	func showEditor(with user: User)
	func showCreator()
	func showFIDE(user: User)
	func showFRC(user: User)
}

protocol EditUserDelegate: class {
	func updateUser(user: User)
}
