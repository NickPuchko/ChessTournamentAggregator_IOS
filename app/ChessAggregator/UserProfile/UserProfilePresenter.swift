

import Foundation

final class UserProfilePresenter {
	weak var view: UserProfileViewInput?
    weak var moduleOutput: UserProfileModuleOutput?
    
	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    private var user: User
    
    init(router: UserProfileRouterInput, interactor: UserProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
        self.user = interactor.getUserInformation()
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
    func getUserInformation() -> User {
        user
    }

    func editProfile() {
        router.showEditor()
    }

    func createEvent() {
        router.showCreator()
    }

    func showMyEvents() {
        router.showMyEvents()
    }

    func showStatistics() {
        router.showStatistics()
    }

    func showFIDE() {
        router.showFIDE(user: user)
    }

    func showFRC() {
        router.showFRC(user: user)
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
}
