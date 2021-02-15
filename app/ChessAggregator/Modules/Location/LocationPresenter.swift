//
//  LocationPresenter.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 14.02.2021.
//  
//

import Foundation

final class LocationPresenter {
	weak var view: LocationViewInput?
    weak var moduleOutput: LocationModuleOutput?
    
	private let router: LocationRouterInput
	private let interactor: LocationInteractorInput
    
    init(router: LocationRouterInput, interactor: LocationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension LocationPresenter: LocationModuleInput {
}

extension LocationPresenter: LocationViewOutput {
    func searchErrorOccurred() {
        router.showSearchError()
    }
}

extension LocationPresenter: LocationInteractorOutput {
}
