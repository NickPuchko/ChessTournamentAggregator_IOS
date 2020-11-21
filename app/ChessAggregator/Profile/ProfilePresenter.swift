
class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewControllerProtocol!
    var router: ProfileRouterProtocol!
    var interactor: ProfileInteractorProtocol!

    required init(view: ProfileViewControllerProtocol) {
        self.view = view
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
        router.showFIDE()
    }

    func showFRC() {
        router.showFRC()
    }
}
