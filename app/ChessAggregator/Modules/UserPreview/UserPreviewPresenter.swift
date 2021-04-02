//
//  UserPreviewPresenter.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 03.03.2021.
//  
//

import Foundation

final class UserPreviewPresenter {
	weak var view: UserPreviewViewInput?
    weak var moduleOutput: UserPreviewModuleOutput?
    
	private let router: UserPreviewRouterInput
	private let interactor: UserPreviewInteractorInput
    
    private var user: User?
    var userPreviewModel: UserPreviewModel?
    init(router: UserPreviewRouterInput, interactor: UserPreviewInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UserPreviewPresenter: UserPreviewModuleInput {
}

extension UserPreviewPresenter: UserPreviewViewOutput {
    
    func showFIDE() {
        if let userInfo = user {
            router.showFIDE(user: userInfo)
        }
    }
    
    func showFRC() {
        if let userInfo = user {
            router.showFRC(user: userInfo)
        } else {

        }
    }
    
    
}

extension UserPreviewPresenter: UserPreviewInteractorOutput {
    
}
private extension UserPreviewPresenter {
    func makeViewModel(user: User) -> UserPreviewModel {
        UserPreviewModel(
                userName: user.player.lastName + " " + user.player.firstName,
                userStatus: user.isOrganizer ? "Организатор" : "Игрок",
                classicFideRating: String(user.player.classicFideRating ?? 0),
                rapidFideRating: String(user.player.rapidFideRating ?? 0),
                blitzFideRating: String(user.player.blitzFideRating ?? 0),
                classicFrcRating: String(user.player.classicFrcRating ?? 0),
                rapidFrcRating: String(user.player.rapidFrcRating ?? 0),
                blitzFrcRating: String(user.player.blitzFrcRating ?? 0),
                isOrganizer: user.isOrganizer)
    }
}
