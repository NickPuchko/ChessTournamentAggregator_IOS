import Foundation
import FirebaseDatabase

class TournamentsInteractor: TournamentsInteractorProtocol {
    weak var presenter: TournamentsPresenterProtocol!
    var events: [Tournament]
    var ref: DatabaseReference
    var phone: String

    required init(presenter: TournamentsPresenterProtocol, ref: DatabaseReference, phone: String) {
        self.presenter = presenter
        self.ref = ref
        self.phone = phone
        events = []
    }

    func loadEventsFromFirebase() -> [Tournament] {
        let events: [Tournament] = []


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
