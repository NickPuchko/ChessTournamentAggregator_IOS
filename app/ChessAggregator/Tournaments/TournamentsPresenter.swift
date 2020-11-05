//
// Created by Administrator on 05.11.2020.
//

import Foundation

class TournamentsPresenter: TournamentsPresenterProtocol {
    weak var view: TournamentsViewProtocol!
    var router: TournamentsRouterProtocol!
    var interactor: TournamentsInteractorProtocol!

    required init(view: TournamentsViewProtocol) {
        self.view = view
    }


    func configureView() {
        view.loadEvents(interactor.events)

    }
}
