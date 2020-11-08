//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit

protocol TournamentsConfiguratorProtocol: class {
    func configure(with viewController: TournamentsViewController)
}

protocol TournamentsViewProtocol: class {
    func loadEvents(_ events: [EventSectionModel])
}

protocol TournamentsPresenterProtocol: class {
    var router: TournamentsRouterProtocol! { get set }
    var interactor: TournamentsInteractorProtocol! { get set }
    var sections: [EventSectionModel] { get set }
    func configureView()
    //func loadEvents(_ events: Tournament) -> [Tournament]
}

protocol TournamentsInteractorProtocol: class {
    var events: [Tournament] { get set }
    func count(mode: Mode) -> Int
    func count() -> Int
    //func sendEvents() -> [Tournament]
}

protocol TournamentsRouterProtocol: class {
    func showApply()
    func showInfo(section: EventSectionModel)
}

protocol CellIdentifiable {
    var cellId: String { get }
}

