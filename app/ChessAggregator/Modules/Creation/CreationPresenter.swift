class CreationPresenter: CreationPresenterProtocol {
    weak var view: CreationViewControllerProtocol!
    var router: CreationRouterProtocol!
    var interactor: CreationInteractorProtocol!

    required init(view: CreationViewControllerProtocol) {
        self.view = view
    }

    func createEvent() {
        interactor.saveEvent()
        router.closeCreation()
    }

    func closeCreation() {
        router.closeCreation()
    }
}
