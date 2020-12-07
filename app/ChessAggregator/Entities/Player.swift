import Foundation

struct Player: Codable {
    var fullName: String = "John Doe"
    var birthdate: Date = Calendar.current.date(from: DateComponents(year: 1953, month: 2, day: 25))!
    var sex: String = "М" // TODO: replace with enum
    
    var fideID: Int? = 24176214 // TODO: replace with parsed id's only
    var classicFideRating: Int?
    var rapidFideRating: Int?
    var blitzFideRating: Int?
    var frcID: Int? = 1606
    var classicFrcRating: Int?
    var rapidFrcRating: Int?
    var blitzFrcRating: Int?

}
