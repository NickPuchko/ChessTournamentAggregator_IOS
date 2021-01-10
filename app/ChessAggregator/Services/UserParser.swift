//
// Created by Иван Лизогуб on 05.12.2020.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import SwiftSoup

class UserParser {
    static func userToFirebaseUser(user: User) -> [String: Any] {
        var result: [String: Any] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let rates = RateParser(frcID: user.player.frcID ?? 0)
        result = [ "lastName": user.player.lastName,
                   "firstName": user.player.firstName,
                   "latinName": user.player.latinName,
                   "sex": user.player.sex.rawValue,
                   "email": user.email,
                   "isOrganizer": user.isOrganizer,
                   "birthdate": dateFormatter.string(from: user.player.birthdate)
        ]
        if rates.count != 0 {
            result = [ "lastName": user.player.lastName,
                       "firstName": user.player.firstName,
                       "latinName": user.player.latinName,
                       "sex": user.player.sex.rawValue,
                       "email": user.email,
                       "isOrganizer": user.isOrganizer,
                       "birthdate": dateFormatter.string(from: user.player.birthdate),
                       "fideClassic": rates[3],
                       "fideRapid": rates[4],
                       "fideBlitz": rates[5],
                       "frcClassic": rates[0],
                       "frcRapid": rates[1],
                       "frcBlitz": rates[2]
            ]
        }
        
        if let patronomicName = user.player.patronomicName {
            result["patronomicName"] = patronomicName
        }
        
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
    static func RateParser(frcID: Int) -> [Int]{
        let userUrlString: String = "https://ratings.ruchess.ru/people/" + String(frcID)
        var result : [Int] = []
        guard let myUrl = URL(string: userUrlString) else{return []}
        do {
            let HTMLString = try String(contentsOf: myUrl, encoding: .utf8)
            let HTMLContent = HTMLString
            do{
                let doc = try SwiftSoup.parse(HTMLContent)
                do{
                    let element = try doc.select("li").array()
                  do{
                    let fide = try element[16].text()
                    let classic = try element[9].text()
                    let rapid = try element[10].text()
                    let blitz = try element[11].text()
                    
                    let fideResult: [String] = fide.components(separatedBy: [" ", "\n", "\t"])
                    
                    let frcResultClassic : [String] =  classic.components(separatedBy: [" ", "\n", "\t"])
                    let frcResultRapid : [String] =  rapid.components(separatedBy: [" ", "\n", "\t"])
                    let frcResultBliz : [String] =  blitz.components(separatedBy: [" ", "\n", "\t"])
                    
                    result.append(Int(fideResult[1].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0)
                    result.append(Int(fideResult[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0)
                    result.append(Int(fideResult[3].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0)

                    result.append(Int(frcResultClassic[2].components(separatedBy:CharacterSet.decimalDigits.inverted).joined()) ?? 0)
                    result.append(Int(frcResultRapid[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0)
                    result.append(Int(frcResultBliz[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) ?? 0)
                    
                   }
                  catch {
                      print("parse error")
                  }
                }
                catch {
                    print("parse error")
                }
            }
        } catch let error{
            print("Error \(error)")
        }
        return result
    }
    
    static func userFromSnapshot(snapshot: DataSnapshot) -> User {
        
        guard let userDict = snapshot.valueInExportFormat() as? NSDictionary else {return User()}
        var user = User()
        user.email = userDict["email"] as? String ?? "test@gmail.com"
        user.isOrganizer = userDict["isOrganizer"] as? Bool ?? false
        user.player = Player(
            lastName: userDict["lastName"] as? String ?? "Доу",
            firstName: userDict["firstName"] as? String ?? "Джон",
            patronomicName: userDict["patronomicName"] as! String?,
            sex: Sex(rawValue: userDict["sex"] as? String ?? "") ?? .male,
            latinName: userDict["latinName"] as? String ?? "Doe John",
            fideID: userDict["fideID"] as? Int ?? 0,
            classicFideRating: userDict["fideClassic"] as? Int ?? nil,
            rapidFideRating: userDict["fideRapid"] as? Int ?? nil,
            blitzFideRating: userDict["fideBlitz"] as? Int ?? nil,
            frcID: userDict["frcID"] as? Int ?? 0,
            classicFrcRating: userDict["frcClassic"] as? Int ?? nil,
            rapidFrcRating: userDict["frcRapid"] as? Int ?? nil,
            blitzFrcRating: userDict["frcBlitz"] as? Int ?? nil
        )


        if user.isOrganizer {
            user.organizer = Organizer(
                    organizationCity: userDict["organizationCity"] as? String ?? "",
                    organizationName: userDict["organizationName"] as? String ?? ""
            )
        }
        return user
    }

    static func usersFromSnapshot(snapshot: DataSnapshot) -> [User] {
        guard let userDict = snapshot.valueInExportFormat() as? [String: Any] else { return [] }
        var users: [User] = []
        for (key, value) in userDict {
            var user = User()
            let thisUser = value as! [String: Any]
            user.id = key
            user.email = thisUser["email"] as? String ?? ""
            user.isOrganizer = thisUser["isOrganizer"] as? Bool ?? false
            if user.isOrganizer {
                user.organizer = Organizer(
                        organizationCity: thisUser["organizationCity"] as? String ?? "",
                        organizationName: thisUser["organizationName"] as? String ?? "")
            }


            user.player = Player(
                    lastName: thisUser["lastName"] as? String ?? "Doe",
                    firstName: thisUser["firstName"] as? String ?? "John",
                    patronomicName: thisUser["patronomicName"] as! String?,
                    sex: Sex(rawValue: thisUser["sex"] as? String ?? "") ?? .male,
                    fideID: thisUser["fideID"] as? Int ?? 0,
                    classicFideRating: thisUser["fideClassic"] as? Int ?? nil,
                    rapidFideRating: thisUser["fideRapid"] as? Int ?? nil,
                    blitzFideRating: thisUser["fideBlitz"] as? Int ?? nil,
                    frcID: thisUser["frcID"] as? Int ?? 0,
                    classicFrcRating: thisUser["fideClassic"] as? Int ?? nil,
                    rapidFrcRating: thisUser["fideRapid"] as? Int ?? nil,
                    blitzFrcRating: thisUser["fideBlitz"] as? Int ?? nil
            )

            users.append(user)

        }

        return users
    }
}
