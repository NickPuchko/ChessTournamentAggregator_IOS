
import Foundation
import UIKit

struct User: Codable {
    var player: Player = Player(lastName: "Doe", firstName: "John", birthdate: Date(), classicFideRating: 2100)
    var phone: String = "88005553535" // TODO: delete
    var email: String = "email@example.com"
    var password: String = "Passw0rd" // TODO: delete
    var isOrganizer: Bool = false
    var organizer: Organizer = Organizer(organizationCity: "Moscow", organizationName: "LUWL")
}

