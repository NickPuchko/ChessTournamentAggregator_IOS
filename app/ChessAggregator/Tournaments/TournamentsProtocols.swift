//
//  TournamentsProtocols.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

protocol TournamentsModuleInput {
	var moduleOutput: TournamentsModuleOutput? { get }
}

protocol TournamentsModuleOutput: class {
}

protocol TournamentsViewInput: class {
}

protocol TournamentsViewOutput: class {
}

protocol TournamentsInteractorInput: class {
}

protocol TournamentsInteractorOutput: class {
}

protocol TournamentsRouterInput: class {
}
