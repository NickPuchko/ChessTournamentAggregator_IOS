//
//  EventApplicationProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 28.12.2020.
//  
//

import Foundation

protocol EventApplicationModuleInput {
	var moduleOutput: EventApplicationModuleOutput? { get }
}

protocol EventApplicationModuleOutput: class {
}

protocol EventApplicationViewInput: class {
}

protocol EventApplicationViewOutput: class {
	func onTapApplication()
}

protocol EventApplicationInteractorInput: class {
	func saveTourToDatabase()
}

protocol EventApplicationInteractorOutput: class {
}

protocol EventApplicationRouterInput: class {
}
