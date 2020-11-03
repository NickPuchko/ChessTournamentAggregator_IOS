//
//  TournamentsModulePresenter.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

final class TournamentsModulePresenter {
	weak var view: TournamentsModuleViewInput?
    weak var moduleOutput: TournamentsModuleModuleOutput?
    
	private let router: TournamentsModuleRouterInput
	private let interactor: TournamentsModuleInteractorInput
    
    init(router: TournamentsModuleRouterInput, interactor: TournamentsModuleInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension TournamentsModulePresenter: TournamentsModuleModuleInput {
}

extension TournamentsModulePresenter: TournamentsModuleViewOutput {
}

extension TournamentsModulePresenter: TournamentsModuleInteractorOutput {
}
