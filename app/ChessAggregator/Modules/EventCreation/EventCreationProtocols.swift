//
//  EventCreationProtocols.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

protocol EventCreationModuleInput {
	var moduleOutput: EventCreationModuleOutput? { get }
}

protocol EventCreationModuleOutput: class {
}

protocol EventCreationViewInput: class {
}

protocol EventCreationViewOutput: class {
	func createEvent()
	func closeCreation()
}

protocol EventCreationInteractorInput: class {
	func saveEvent()
}

protocol EventCreationInteractorOutput: class {
}

protocol EventCreationRouterInput: class {
	func closeCreation()
}
