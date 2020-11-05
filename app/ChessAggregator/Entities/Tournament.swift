import Foundation

class Tournament{
    var name: String
    var mode: Mode
    var date: Date
    
   init(json: [String: Any]) {
       name = json["name"] as? String ?? ""
       mode = json["mode"] as? Mode ?? .classic
       date = json["date"] as? Date ?? Date(timeIntervalSince1970: TimeInterval(1))
   }

    init(name: String, mode: Mode, date: Date) {
        self.name = name
        self.mode = mode
        self.date = date
    }
}

enum Mode: String, Codable {
    case classic, rapid, blitz, bullet
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
