import Foundation

struct Player: Codable {
    var fullName: String
    var birthdate: Date
    var rating: Int // TODO: replace with parsed id's only
    
    var fideID: Int?
    var frcID: Int?
    var sex: String?

    init(fullName: String = "John Doe", birthdate: Date = Calendar.current.date(from: DateComponents(year: 1953, month: 2, day: 25))!, rating: Int?, fideID: Int? = 24176214, frcID: Int? = 1606) {
        self.fullName = fullName
        self.birthdate = birthdate
        if let ELOrating = rating {
            self.rating = ELOrating
        } else {
            self.rating = 0
        }
        self.fideID = fideID
        self.frcID = frcID
    }
}
