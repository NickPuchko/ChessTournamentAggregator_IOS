//
//  MyEventsProtocols.swift
//  app
//
//  Created by Иван Лизогуб on 08.12.2020.
//  
//

import Foundation

enum LoadingDataType {
	case nextPage
	case reload
}

protocol MyEventsModuleInput {
	var moduleOutput: MyEventsModuleOutput? { get }
}

protocol MyEventsModuleOutput: class {
}

protocol MyEventsViewInput: class {
	func updateView(with viewModels: [MyEventViewModel])
}

protocol MyEventsViewOutput: class {
	func viewDidLoad()
	func willDisplay()
}

protocol MyEventsInteractorInput: class {
	func reload()
}

protocol MyEventsInteractorOutput: class {
	func didLoad(with event: Tournament, loadType: LoadingDataType)
}

protocol MyEventsRouterInput: class {
}
