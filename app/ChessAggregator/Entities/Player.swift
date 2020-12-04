import Foundation

struct Player: Codable {
    var fullName: String
    var birthdate: Date
    var rating: Int // TODO: replace with getter property - parsed by id
    var sex: String // TODO: replace with enum
    var fideID: Int?
    var frcID: Int?

    init(fullName: String = "John Doe", birthdate: Date = Calendar.current.date(from: DateComponents(year: 1953, month: 2, day: 25))!, rating: Int?, sex: String = "Male", fideID: Int? = 24176214, frcID: Int? = 1606) {
        self.fullName = fullName
        self.birthdate = birthdate
        if let ELOrating = rating {
            self.rating = ELOrating
        } else {
            self.rating = 0
        }
        self.sex = sex
        self.fideID = fideID
        self.frcID = frcID
    }
}
