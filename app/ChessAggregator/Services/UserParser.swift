//
// Created by Иван Лизогуб on 05.12.2020.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserParser {
    static func userToFirebaseUser(user: User) -> [String: Any] {
        var result: [String: Any] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = Locale(identifier: "ru_RU")
        result = [ "fullName": user.player.fullName,
                   "phone": user.phone,
                   "email": user.email,
                   "password": user.password,
                   "isOrganizer": user.isOrganizer,
                   "birthdate": dateFormatter.string(from: user.player.birthdate)
        ]
        if let fideID = user.player.fideID {
            result["fideID"] =  fideID
        }
        if let frcID = user.player.frcID {
            result["frcID"] = frcID
        }
        if let organizationName = user.organizer.organizationName {
            result["organizationName"] = organizationName
        }
        if let organizationCity = user.organizer.organizationCity {
            result["organizationCity"] = organizationCity
        }
        return result
    }

    static func userFromSnapshot(snapshot: DataSnapshot) -> User {
        let userDict = snapshot.valueInExportFormat() as! NSDictionary
        var user = User()
        user.phone = userDict["phone"] as? String ?? "88005553535"
        user.email = userDict["email"] as? String ?? "test@gmail.com"
        user.isOrganizer = userDict["isOrganizer"] as? Bool ?? false
        user.password = userDict["password"] as? String ?? ""
        user.player = Player(
                fullName: userDict["fullName"] as? String ?? "Mr John Doe",
                eventsIDs: userDict["eventsIDs"] as? [String] ?? [],
                classicFideRating: userDict["classicFideRating"] as? Int ?? 2054, // TODO: Parse ratings from FIDE/FRC
                rapidFideRating: userDict["rapidFideRating"] as? Int ?? 0,
                blitzFideRating: userDict["blitzFideRating"] as? Int ?? 0,
                classicFrcRating: userDict["classicFrcRating"] as? Int ?? 0,
                rapidFrcRating: userDict["rapidFrcRating"] as? Int ?? 0,
                blitzFrcRating: userDict["blitzFrcRating"] as? Int ?? 0
        )
        user.organizer = Organizer(
                organizationCity: userDict["organizationCity"] as? String ?? "",
                organizationName: userDict["organizationName"] as? String ?? "",
                eventsIDs: userDict["eventsIDs"] as? [String] ?? []
        )
        return user
    }
}