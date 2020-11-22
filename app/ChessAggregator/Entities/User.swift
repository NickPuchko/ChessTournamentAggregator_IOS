
import Foundation
import UIKit

struct User: Codable{
    var player: Player
    var phone: String
    var isAdmin: Bool
    // TODO: phone class
    
    init(player: Player = Player(fullName: "Doe John", birthdate: Date(), rating: 2100), phone: String = "88005553535", isAdmin: Bool = false) {
        self.player = player
        self.phone = phone
        self.isAdmin = isAdmin
    }
}

func saveUser(currentUser: User) {
    let local = UserDefaults.standard
    local.set(try? PropertyListEncoder().encode(currentUser), forKey: "currentUser")
    UserDefaults.standard.synchronize()
}

func currentUserPhone() -> String{
    var currentUser: User
    let local = UserDefaults.standard
    if let user = local.object(forKey: "currentUser") as? Data {
        currentUser = try! PropertyListDecoder().decode(User.self, from: user)
    } else {
        currentUser = User(phone: "900")
    }
    return currentUser.phone
}
