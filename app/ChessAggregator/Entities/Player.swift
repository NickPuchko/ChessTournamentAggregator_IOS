import Foundation

struct Player: Codable {
    var fullName: String
    var birthdate: Date
    var rating: Int

init(fullName: String = "John Doe", birthdate: Date = Calendar.current.date(from: DateComponents(year: 1953, month: 2, day: 25))!, rating: Int?) {
        self.fullName = fullName
        self.birthdate = birthdate
        if let ELOrating = rating {
            self.rating = ELOrating
        } else {
            self.rating = 0
        }
    }
}
