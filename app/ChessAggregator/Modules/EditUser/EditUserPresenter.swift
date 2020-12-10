//
//  EditUserPresenter.swift
//  app
//
//  Created by Administrator on 10.12.2020.
//  
//

import Foundation

final class EditUserPresenter {
	weak var view: EditUserViewInput?
    weak var moduleOutput: EditUserModuleOutput?
    
	private let router: EditUserRouterInput
	private let interactor: EditUserInteractorInput
    
    init(router: EditUserRouterInput, interactor: EditUserInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EditUserPresenter: EditUserModuleInput {
}

extension EditUserPresenter: EditUserViewOutput {
    func close() {
        router.close()
    }

    func saveChanges() {
        interactor.saveChanges()
        router.close()
    }

}

extension EditUserPresenter: EditUserInteractorOutput {
}
