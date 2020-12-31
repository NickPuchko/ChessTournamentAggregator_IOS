
import Foundation
import UIKit

struct User: Codable {
    var player: Player = Player(lastName: "Doe", firstName: "John", birthdate: Date(), classicFideRating: 2100)
    var phone: String = "88005553535"
    var email: String = "email@example.com"
    var password: String = "Passw0rd"
    var isOrganizer: Bool = false
    var organizer: Organizer = Organizer(organizationCity: "Moscow", organizationName: "LUWL")
    // TODO: phone class

}

func saveUser(currentUser: User) {
    let local = UserDefaults.standard
    local.set(try? PropertyListEncoder().encode(currentUser), forKey: "currentUser")
    UserDefaults.standard.synchronize()
}

func currentUserPhone() -> String {
    var currentUser: User
    let local = UserDefaults.standard
    if let user = local.object(forKey: "currentUser") as? Data {
        currentUser = try! PropertyListDecoder().decode(User.self, from: user)
    } else {
        currentUser = User(phone: "900")
    }
    return currentUser.phone
}
