//
// Created by Иван Лизогуб on 18.11.2020.
//

import UIKit

class BaseRouter {
    var navigationControllerProvider: (() -> UINavigationController?)?
    var viewControllerProvider: (() -> UIViewController?)?

    var navigationController: UINavigationController? {
        self.navigationControllerProvider?()
    }

    var viewController: UIViewController? {
        self.viewControllerProvider?()
    }
}
