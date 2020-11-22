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
}

protocol SearchTournamentsViewOutput: class {
	func configureView()
	func showInfo(section: EventSectionModel)
	func showApply()
}

protocol SearchTournamentsInteractorInput: class {
	func loadEventsFromFirebase() -> [Tournament]
	func count(mode: Mode) -> Int
	func count() -> Int
}

protocol SearchTournamentsInteractorOutput: class {
}

protocol SearchTournamentsRouterInput: class {
	func showInfo(section: EventSectionModel)
	func showApply()
}
