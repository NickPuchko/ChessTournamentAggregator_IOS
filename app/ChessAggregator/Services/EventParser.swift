
import Firebase
import Foundation

class EventParser {
    static func eventsFromSnapshot(snapshot: DataSnapshot) -> [Tournament]? {
        guard let eventDict = snapshot.valueInExportFormat() as? [String: Any] else { return nil }
        var events: [Tournament] = []
        for (key, value) in eventDict {
            var event = Tournament(id: key )
            let thisEvent = value as! [String: Any]

            event.openDate = thisEvent["openDate"] as? String ?? "01.01.1970"
            event.closeDate = thisEvent["closeDate"] as? String ?? "01.01.1970"
            event.fee = thisEvent["fee"] as? Int ?? 0
            event.tours = thisEvent["tours"] as? Int ?? 9

            event.minutes = thisEvent["minutes"] as? Int ?? 1
            event.seconds = thisEvent["seconds"] as? Int ?? 0
            event.increment = thisEvent["increment"] as? Int ?? 0

            event.location = thisEvent["location"] as? String ?? "Moscow"
            event.organizerId = thisEvent["organizerId"] as? String ?? ""
            event.mode = Mode.init(rawValue: (thisEvent["mode"] as? String ?? "classic")) ?? .classic
            event.name = thisEvent["name"] as? String ?? "Some event"
            event.participantsCount = (thisEvent["participants"] as? [String: Any] ?? [:]).count
            event.prizeFund = thisEvent["prizeFund"] as? Int ?? 0
            event.ratingType = RatingType.init(rawValue: (thisEvent["ratingType"] as? String ?? "Без обсчёта")) ?? .without
            event.url = URL(string: thisEvent["url"] as? String ?? "https://vk.com/oobermensch")!

            events.append(event)

        }

        return events
    }

    static func eventsToEventViewModel(_ events: [Tournament]) -> [EventViewModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium

        let intervalFormatter = DateIntervalFormatter()
        intervalFormatter.locale = dateFormatter.locale
        intervalFormatter.dateStyle = .short
        intervalFormatter.timeStyle = .none

        return events.map { event in
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let open = dateFormatter.date(from: event.openDate) ?? Date()
            let close = dateFormatter.date(from: event.closeDate) ?? Date()
            let date = intervalFormatter.string(from: open, to: close)
            return EventViewModel(
                    event: event,
                    eventId: event.id,
                    name: event.name,
                    location: event.location,
                    mode: event.mode.rawValue,
                    ratingType: event.ratingType.rawValue,
                    date: date)
        }
    }

}
