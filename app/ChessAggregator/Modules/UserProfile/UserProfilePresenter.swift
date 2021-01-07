

import Foundation
import Firebase
final class UserProfilePresenter {
	weak var view: UserProfileViewInput?
    weak var moduleOutput: UserProfileModuleOutput?
    
	private let router: UserProfileRouterInput
	private let interactor: UserProfileInteractorInput
    private var user: User?
    
    init(router: UserProfileRouterInput, interactor: UserProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UserProfilePresenter: UserProfileModuleInput {
}

extension UserProfilePresenter: UserProfileViewOutput {
    

    func editProfile() {
        if let userInfo = user {
            router.showEditor(with: userInfo)
            //interactor.reloadData()
        }

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
    func signOut() {
        let auth = Auth.auth()
        do{
            try auth.signOut()
        }catch let signOutError{
            print("Error: \(signOutError)")
        }
    }
}

extension UserProfilePresenter: UserProfileInteractorOutput {
    func updateUser(user: User) {
        self.user = user
        view!.updateUser(user: user)
    }
}
