//
//  SearchTournamentsProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation

protocol SearchTournamentsModuleInput {
	var moduleOutput: SearchTournamentsModuleOutput? { get }
}

protocol SearchTournamentsModuleOutput: class {
}

protocol SearchTournamentsViewInput: class {
	func updateViewModels(with viewModels: [EventViewModel])
	func updateFilteredViewModels(with viewModels: [EventViewModel])
}

protocol SearchTournamentsViewOutput: class {
	func filter(events: [EventViewModel], with text: String)
	func configureView()
	func showInfo(event: EventViewModel)
	func showApply()
	func refreshOnline()
}

protocol SearchTournamentsInteractorInput: class {
	func loadEvents()
	func refreshEvents()
}

protocol SearchTournamentsInteractorOutput: class {
	func updateView(with events: [Tournament])
}

protocol SearchTournamentsRouterInput: class {
	func showInfo(event: EventViewModel)
	func showApply()
}
