
class TournamentsPresenter: TournamentsPresenterProtocol {

    weak var view: TournamentsViewProtocol!
    var router: TournamentsRouterProtocol!
    var interactor: TournamentsInteractorProtocol!

    var sections: [EventSectionModel] = []

    required init(view: TournamentsViewProtocol) {
        self.view = view
        sections = []
    }

    func configureView() {
        view.loadEvents(interactor.loadSections())
    }

    func updateView() {
        configureView()
        view.updateFeed()
    }
}
