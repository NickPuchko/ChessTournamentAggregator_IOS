//
//  LocationProtocols.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 14.02.2021.
//  
//

import Foundation

protocol LocationModuleInput {
	var moduleOutput: LocationModuleOutput? { get }
}

protocol LocationModuleOutput: class {
}

protocol LocationViewInput: class {
}

protocol LocationViewOutput: class {
	func searchErrorOccurred()
}

protocol LocationInteractorInput: class {
}

protocol LocationInteractorOutput: class {
}

protocol LocationRouterInput: class {
	func showSearchError()
}
