//
// Created by Administrator on 05.11.2020.
//

import Foundation

class TournamentsRouter: TournamentsRouterProtocol {
    weak var viewController: TournamentsViewController!

    init(VC: TournamentsViewController) {
        self.viewController = VC
    }

    func showApply() {
        //viewController.present(AuthViewController(), animated: true)
    }
}
