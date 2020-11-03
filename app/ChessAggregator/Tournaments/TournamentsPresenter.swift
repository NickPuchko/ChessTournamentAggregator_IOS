//
//  TournamentsPresenter.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

final class TournamentsPresenter {
	weak var view: TournamentsViewInput?
    weak var moduleOutput: TournamentsModuleOutput?
    
	private let router: TournamentsRouterInput
	private let interactor: TournamentsInteractorInput
    
    init(router: TournamentsRouterInput, interactor: TournamentsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TournamentsPresenter: TournamentsModuleInput {
}

extension TournamentsPresenter: TournamentsViewOutput {
}

extension TournamentsPresenter: TournamentsInteractorOutput {
}
