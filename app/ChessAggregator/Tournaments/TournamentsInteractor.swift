//
// Created by Administrator on 05.11.2020.
//

import Foundation

class TournamentsInteractor: TournamentsInteractorProtocol {
    weak var presenter: TournamentsPresenterProtocol!
    var events: [Tournament]

    required init(presenter: TournamentsPresenterProtocol) {
        self.presenter = presenter
        self.events = []

        addEvent(event: Tournament(name: "HSE cup", mode: .rapid, date: Date(timeIntervalSince1970: 100)))
        addEvent(event: Tournament(name: "Aeroflot open", mode: .classic, date: Date(timeIntervalSince1970: 200)))
        //TODO: Сделать инициализацию ивентов из бэка
    }

    func addEvent(event: Tournament) {
        events.append(event)
    }
}
