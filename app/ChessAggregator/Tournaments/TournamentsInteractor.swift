//
// Created by Administrator on 05.11.2020.
//

import Foundation

class TournamentsInteractor: TournamentsInteractorProtocol {
    weak var presenter: TournamentsPresenterProtocol!
    var events: [Tournament]

    required init(presenter: TournamentsPresenterProtocol) {
        self.presenter = presenter
        events = []
    }

    func loadEventsFromFirebase() -> [Tournament] {
        var events: [Tournament] = []
        // TODO: Написить метод загрузки всех турниров из json (Realtime Database)
        return events
    }
}

extension TournamentsInteractor {
    func count(mode: Mode) -> Int {
        let filterEvents = events.filter { $0.mode == mode}
        return filterEvents.count
    }

    func count() -> Int {
        events.count
    }
}
