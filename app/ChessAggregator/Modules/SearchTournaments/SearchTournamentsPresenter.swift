//
//  SearchTournamentsPresenter.swift
//  app
//
//  Created by Иван Лизогуб on 21.11.2020.
//  
//

import Foundation

final class SearchTournamentsPresenter {
	weak var view: SearchTournamentsViewInput?
    weak var moduleOutput: SearchTournamentsModuleOutput?
    
	private let router: SearchTournamentsRouterInput
	private let interactor: SearchTournamentsInteractorInput

    private var sections: [EventSectionModel] = []
    
    init(router: SearchTournamentsRouterInput, interactor: SearchTournamentsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SearchTournamentsPresenter: SearchTournamentsModuleInput {
}

extension SearchTournamentsPresenter: SearchTournamentsViewOutput {
    func refreshOnline() {
        interactor.refreshEvents()
    }

    func showInfo(section: EventSectionModel) {
        router.showInfo(section: section)
    }

    func showApply() {
        router.showApply()
    }

    func configureView() {
        view?.loadEvents(interactor.loadSections())
    }
    
}

extension SearchTournamentsPresenter: SearchTournamentsInteractorOutput {
    func updateView() {
        configureView()
        view?.updateFeed()
    }
}
