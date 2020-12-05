//
// Created by Иван Лизогуб on 05.12.2020.
//

import Foundation

class UserParser {
    static func userToFirebaseUser(user: User) -> [String: Any] {
        var result: [String: Any] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
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
}