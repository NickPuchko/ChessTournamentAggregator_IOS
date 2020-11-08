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

        //addEvent(event: Tournament(name: "HSE cup", mode: .rapid, date: "10.12.2020", location: "Москва", ratingType: "Без обсчёта рейтинга"))
        //addEvent(event: Tournament(name: "Aeroflot open", mode: .classic, date: "18.01.2021", location: "Москва", ratingType: "FIDE"))
        //TODO: Сделать инициализацию ивентов из бэка
    }


    func addEvent(event: Tournament) {
        events.append(event)
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
