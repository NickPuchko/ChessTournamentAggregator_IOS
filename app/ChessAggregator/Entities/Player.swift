import Foundation

struct Player: Codable {
    var fullName: String = "Doe John"
    var birthdate: Date = Date(timeIntervalSince1970: 100)
    var rating: Int = 0

    init(fullName: String, birthdate: Date, rating: Int?) {
        self.fullName = fullName
        self.birthdate = birthdate
        if let ELOrating = rating {
            self.rating = ELOrating
        } else {
            self.rating = 0
        }
    }
}
