//
//  EditUserProtocols.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation

protocol EditUserModuleInput {
	var moduleOutput: EditUserModuleOutput? { get }
}

protocol EditUserModuleOutput: class {
	var currentUser: User { get set }
}

protocol EditUserViewInput: class {
}

protocol EditUserViewOutput: class {
	func close()
	func saveChanges()
}

protocol EditUserInteractorInput: class {
	func saveChanges()
}

protocol EditUserInteractorOutput: class {
}

protocol EditUserRouterInput: class {
	func close()
}
