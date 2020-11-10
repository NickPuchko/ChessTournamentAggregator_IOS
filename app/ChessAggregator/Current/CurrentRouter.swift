//
// Created by Administrator on 10.11.2020.
//

import Foundation

class CurrentRouter: CurrentRouterProtocol {
    weak var viewController: CurrentViewControllerProtocol!

    required init(VC: CurrentViewControllerProtocol) {
        self.viewController = VC
    }

    func showInfo() {
        //let infoViewController
    }
}
