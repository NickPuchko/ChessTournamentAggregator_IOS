//
//  ManagerProtocols.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import Foundation

protocol ManagerModuleInput {
	var moduleOutput: ManagerModuleOutput? { get }
}

protocol ManagerModuleOutput: class {
}

protocol ManagerViewInput: class {
	func reloadView(players: [PlayerModel], elo: Int, participants: Int)
	func reloadEvent(event: Tournament)
}

protocol ManagerViewOutput: class {
	func eventState() -> Tournament
	func onTapSite()
	func onTapManage()
}

protocol ManagerInteractorInput: class {
	func requestEvent() -> Tournament
	func reloadData()
}

protocol ManagerInteractorOutput: class {
	func reloadData(players: [PlayerModel], elo: Int, participants: Int)
	func reloadEvent(event: Tournament)
}

protocol ManagerRouterInput: class {
	func showSite(url: URL)
	func showMenu(event: Tournament)
}

protocol EventCreationDelegate: class {
	func updateEvent(event: Tournament)
}
