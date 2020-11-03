//
//  AuthPresenter.swift
//  app
//
//  Created by Administrator on 04.11.2020.
//  
//

import Foundation

final class AuthPresenter {
	weak var view: AuthViewInput?
    weak var moduleOutput: AuthModuleOutput?
    
	private let router: AuthRouterInput
	private let interactor: AuthInteractorInput
    
    init(router: AuthRouterInput, interactor: AuthInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthPresenter: AuthModuleInput {
}

extension AuthPresenter: AuthViewOutput {
}

extension AuthPresenter: AuthInteractorOutput {
}
