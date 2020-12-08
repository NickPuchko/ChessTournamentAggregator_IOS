//
//  EventCreationPresenter.swift
//  ChessAggregator
//
//  Created by Administrator on 05.12.2020.
//  
//

import Foundation

final class EventCreationPresenter {
	weak var view: EventCreationViewInput?
    weak var moduleOutput: EventCreationModuleOutput?
    
	private let router: EventCreationRouterInput
	private let interactor: EventCreationInteractorInput
    
    init(router: EventCreationRouterInput, interactor: EventCreationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventCreationPresenter: EventCreationModuleInput {
}

extension EventCreationPresenter: EventCreationViewOutput {
    func chooseMode(minutes: Int, seconds: Int, increment: Int) -> Mode {
        interactor.chooseMode(minutes: minutes, seconds: seconds, increment: increment)
    }

    func showRules() {
        router.showRules()
    }

    func createEvent() {
        interactor.saveEvent()
        router.closeCreation()
    }

    func closeCreation() {
        router.closeCreation()
    }

}

extension EventCreationPresenter: EventCreationInteractorOutput {
}
