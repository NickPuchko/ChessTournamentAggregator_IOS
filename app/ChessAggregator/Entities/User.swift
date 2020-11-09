//
// Created by Administrator on 08.11.2020.
//

import Foundation

struct User: Codable{
    var player: Player = Player(fullName: "Doe John", birthdate: Date(timeIntervalSince1970: 1), rating: 2100)
    var phone: String = "88005553535"
    // TODO: phone class

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