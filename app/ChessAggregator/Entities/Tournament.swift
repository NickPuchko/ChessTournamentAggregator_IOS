import Foundation

struct Tournament{
    var name: String = "Турнир"
    var mode: Mode = .classic
    var date: String = "01.01.1970"
    var location: String = "Москва"
    var ratingType: String = "FIDE"

    var timeControl: String = "90+30"
    var prizeFund: Int = 0
    var fee: Int = 0
    var url: URL = URL(string: "https://vk.com/oobermensch")!

    // TODO: class Date - DateFormatter!
    // TODO: class Location
    // TODO: enum RatingType


    mutating func getFromJson(json: [String: Any]) {
        name = json["name"] as? String ?? "Турнир"
        mode = json["mode"] as? Mode ?? .classic
        date = json["date"] as? String ?? "01.01.1970"
        location = json["location"] as? String ?? "Москва"
        ratingType = json["ratingType"] as? String ?? "FIDE"
    }

}

enum Mode: String, Codable, CaseIterable{
    case classic = "Классический контроль", rapid = "Рапид", blitz = "Блиц", bullet = "Пуля"
}


/*struct TableModel{
   // var response: String

    var response: String
    var access_token: String
    var refresh_token: String

    init(json: [String: Any]) {
        response = json["response"] as? String ?? ""
        access_token = json["access_token"] as? String ?? ""
        refresh_token = json["refresh_token"] as? String ?? ""
    }
}*/
