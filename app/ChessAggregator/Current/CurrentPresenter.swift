//
// Created by Administrator on 10.11.2020.
//

import Foundation

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
