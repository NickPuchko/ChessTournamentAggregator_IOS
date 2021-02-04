//
//  ManagerPresenter.swift
//  ChessAggregator
//
//  Created by Administrator on 03.02.2021.
//  
//

import Foundation

final class ManagerPresenter {
	weak var view: ManagerViewInput?
    weak var moduleOutput: ManagerModuleOutput?
    
	private let router: ManagerRouterInput
	private let interactor: ManagerInteractorInput
    
    init(router: ManagerRouterInput, interactor: ManagerInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ManagerPresenter: ManagerModuleInput {
}

extension ManagerPresenter: ManagerViewOutput {
    func onTapManage() {
        router.showMenu(event: interactor.requestEvent())
    }

    func onTapSite() {
        router.showSite(url: interactor.requestEvent().url)
    }

    func eventState() -> Tournament {
        interactor.requestEvent()
    }
}

extension ManagerPresenter: ManagerInteractorOutput {
    func reloadEvent(event: Tournament) {
        view?.reloadEvent(event: event)
    }

    func reloadData(players: [PlayerModel], elo: Int, participants: Int) {
        view?.reloadView(
                players: players,
                elo: elo,
                participants: participants
        )
    }

}
