//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

protocol TournamentsConfiguratorProtocol: class {
    func configure(with viewController: TournamentsViewController)
}

protocol TournamentsViewProtocol: class {
    func loadEvents(_ events: [Tournament])
}

protocol TournamentsPresenterProtocol: class {
    var router: TournamentsRouterProtocol! { get set }
    func configureView()
}

protocol TournamentsInteractorProtocol: class {
    var events: [Tournament] { get set }
}

protocol TournamentsRouterProtocol: class {
    func showApply()
}

