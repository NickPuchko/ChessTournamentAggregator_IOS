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
	func loadEvents(_ sections: [EventSectionModel])
	func updateFeed()
}

protocol SearchTournamentsViewOutput: class {
	func configureView()
	func showInfo(section: EventSectionModel)
	func showApply()
	func refreshOnline()
}

protocol SearchTournamentsInteractorInput: class {
	func loadSections() -> [EventSectionModel]
	func count(mode: Mode) -> Int
	func count() -> Int
	func refreshEvents()
}

protocol SearchTournamentsInteractorOutput: class {
	func updateView()
}

protocol SearchTournamentsRouterInput: class {
	func showInfo(section: EventSectionModel)
	func showApply()
}
