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

        ref.child("Tournaments").observeSingleEvent(of: .value, with: { [weak self] snapshot in
            self?.events = EventParser.eventsFromSnapshot(snapshot: snapshot)
            self?.presenter.updateView()
        })
    }
}

extension TournamentsInteractor {
    // MARK: методы подсчёта турниров, могут пригодиться
//    func count(mode: Mode) -> Int {
//        let filterEvents = events.filter { $0.mode == mode}
//        return filterEvents.count
//    }
//
//    func count() -> Int {
//        events.count
//    }

    func loadSections() -> [EventSectionModel] {
        var sections: [EventSectionModel] = []
        for event in self.events {
            sections.append(EventSectionModel(event: event))
        }
        return sections
    }
}
