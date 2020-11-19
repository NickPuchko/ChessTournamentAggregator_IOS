import Foundation

struct Tournament: Identifiable{
    var id: Int

    var name: String
    var mode: Mode
    var date: String
    var location: String
    var ratingType: RatingType

    var timeControl: String
    var prizeFund: Int
    var fee: Int
    var url: URL

    // TODO: class Date - DateFormatter!
    // TODO: class Location

    init(id: Int = 0, name: String = "Some event", mode: Mode = .classic, date: String = "01.01.1970",
         location: String = "Moscow", ratingType: RatingType = .without, timeControl: String = "90+30",
         prizeFund: Int = 0, fee: Int = 0, url: URL = URL(string: "https://vk.com/oobermensch")!) {
        self.id = id
        self.name = name
        self.mode = mode
        self.date = date
        self.location = location
        self.ratingType = ratingType
        self.timeControl = timeControl
        self.prizeFund = prizeFund
        self.fee = fee
        self.url = url
    }
}

enum Mode: String, Codable, CaseIterable{
    case classic = "Classic", rapid = "Rapid", blitz = "Blitz", bullet = "Bullet"
}

enum RatingType: String, Codable, CaseIterable{
    case fide = "FIDE", russian = "Russian", without = "Without"
}
