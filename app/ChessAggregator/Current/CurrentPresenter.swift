
class CurrentPresenter: CurrentPresenterProtocol {
    weak var view: CurrentViewControllerProtocol!

    var router: CurrentRouterProtocol!
    var interactor: CurrentInteractorProtocol!

    required init(view: CurrentViewControllerProtocol) {
        self.view = view
    }

    func tappedInfo() {
        router.showInfo()
    }
}
