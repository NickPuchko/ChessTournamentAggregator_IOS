//
// Created by Administrator on 05.11.2020.
//

import Foundation
import UIKit
import Firebase

protocol TournamentsConfiguratorProtocol: class {
    func configure(with viewController: TournamentsViewController)
}

protocol TournamentsViewProtocol: class {
    var ref: DatabaseReference { get set }
    var phone: String { get set }
    init(ref: DatabaseReference, withId phone: String)
    func loadEvents(_ events: [EventSectionModel])
}

protocol TournamentsPresenterProtocol: class {
    var router: TournamentsRouterProtocol! { get set }
    var interactor: TournamentsInteractorProtocol! { get set }
    var sections: [EventSectionModel] { get set }
    func createEvents() -> [Tournament]
    func configureView()
    //func loadEvents(_ events: Tournament) -> [Tournament]
}

protocol TournamentsInteractorProtocol: class {
    var ref: DatabaseReference { get set }
    var phone: String { get set }
    var events: [Tournament] { get set }
    init(presenter: TournamentsPresenterProtocol, ref: DatabaseReference, phone: String)
    func count(mode: Mode) -> Int
    func count() -> Int
    func loadEventsFromFirebase() -> [Tournament]
}

protocol TournamentsRouterProtocol: class {
    func showApply()
    func showInfo(section: EventSectionModel)
}

protocol CellIdentifiable {
    var cellId: String { get }
}

