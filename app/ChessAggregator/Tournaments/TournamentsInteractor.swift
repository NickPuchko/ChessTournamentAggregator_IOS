import Foundation
import FirebaseDatabase

class TournamentsInteractor: TournamentsInteractorProtocol {
    weak var presenter: TournamentsPresenterProtocol!
    var events: [Tournament]
    let ref: DatabaseReference
    let phone: String

    required init(presenter: TournamentsPresenterProtocol, ref: DatabaseReference, phone: String) {
        self.presenter = presenter
        self.ref = ref
        self.phone = phone
        events = []
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

    func loadSections() -> [EventSectionModel] {
        var sections: [EventSectionModel] = []

        let bestURL = URL(string: "https://vk.com/oobermensch")!

        ref.child("Tournaments").observe(.value) { (Tournament: DataSnapshot) in
            print (Tournament.value!)
        }
        // TODO: Внести турниры в realtime database
        events.append(Tournament(name: "HSE cup", mode: .rapid, date: "10.12.2020", location: "Москва", ratingType: "Без обсчёта рейтинга", timeControl: "15+0", prizeFund: 10000, fee: 500, url: URL(string: "https://sport.hse.ru/chess") ?? bestURL))
        events.append(Tournament(name: "Moscow open", mode: .classic, date: "18.01.2021", location: "Москва", ratingType: "FIDE", timeControl: "90+30", prizeFund: 12000000, fee: 50000, url: URL(string: "https://ruchess.ru/championship/detail/2020/aeroflot_open_2020/") ?? bestURL))
        events.append(Tournament(name: "Чемпионат России", mode: .blitz, date: "24.12.2020", location: "Сочи", ratingType: "Российский рейтинг", timeControl: "3+2", prizeFund: 2000000, fee: 25000, url: URL(string: "https://chesspro.ru/tournaments/russia_ch_higher_league20") ?? bestURL))

        for event in events {
            sections.append(EventSectionModel(event: event))
        }

        return sections
    }
}
