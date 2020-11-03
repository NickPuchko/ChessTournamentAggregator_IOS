//
//  TournamentsModuleProtocols.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

protocol TournamentsModuleModuleInput {
	var moduleOutput: TournamentsModuleModuleOutput? { get }
}

protocol TournamentsModuleModuleOutput: class {
}

protocol TournamentsModuleViewInput: class {
}

protocol TournamentsModuleViewOutput: class {
}

protocol TournamentsModuleInteractorInput: class {
}

protocol TournamentsModuleInteractorOutput: class {
}

protocol TournamentsModuleRouterInput: class {
}
