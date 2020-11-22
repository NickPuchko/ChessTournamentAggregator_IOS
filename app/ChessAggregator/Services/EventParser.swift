
import Firebase
import Foundation

class EventParser {
    static func eventsFromSnapshot(snapshot: DataSnapshot) -> [Tournament] {
        let eventDict = snapshot.valueInExportFormat() as! NSDictionary
        var events: [Tournament] = []
        for (key, value) in eventDict {
            var event = Tournament(id: key as! String)
            let thisEvent = value as! NSDictionary

            event.date = thisEvent["date"] as? String ?? "01.01.1970"
            event.fee = thisEvent["fee"] as? Int ?? 0
            event.location = thisEvent["location"] as? String ?? "Moscow"
            event.mode = Mode.init(rawValue: (thisEvent["mode"] as? String ?? "classic")) ?? .classic
            event.name = thisEvent["name"] as? String ?? "Some event"
            event.prizeFund = thisEvent["prizeFund"] as? Int ?? 0
            event.ratingType = RatingType.init(rawValue: (thisEvent["ratingType"] as? String ?? "without")) ?? .without
            event.url = URL(string: thisEvent["url"] as? String ?? "https://vk.com/oobermensch")!

            events.append(event)
        }
        return events
    }
}
