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
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let rates = RateParser(userUrlString: ("https://ratings.ruchess.ru/people/"+String(user.player.frcID ?? 0)))
        result = [ "fullName": user.player.fullName,
                   "phone": user.phone,
                   "email": user.email,
                   "password": user.password,
                   "isOrganizer": user.isOrganizer,
                   "birthdate": dateFormatter.string(from: user.player.birthdate)
        ]
        if rates.count != 0 {
            result = [ "fullName": user.player.fullName,
                       "phone": user.phone,
                       "email": user.email,
                       "password": user.password,
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
    static func RateParser(userUrlString: String)->[String]{
        var result : [String] = []
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
                    let fast = try element[10].text()
                    let bliz = try element[11].text()
                    
                    let fideResult: [String] =  fide.components(separatedBy: [" ", "\n", "\t"])
                    
                    let frcResultClassic : [String] =  classic.components(separatedBy: [" ", "\n", "\t"])
                    let frcResultFast : [String] =  fast.components(separatedBy: [" ", "\n", "\t"])
                    let frcResultBliz : [String] =  bliz.components(separatedBy: [" ", "\n", "\t"])
                    
                    let STDnumberFide = fideResult[1].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    let RPDnumberFide = fideResult[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    let BLZnumberFide = fideResult[3].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    
                    let STDnumberFRC = frcResultClassic[2].components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                    let RPDnumberFRC = frcResultFast[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    let BLZnumberFRC = frcResultBliz[2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    
                    result.append(STDnumberFide)
                    result.append(RPDnumberFide)
                    result.append(BLZnumberFide)
                    
                    result.append(STDnumberFRC)
                    result.append(RPDnumberFRC)
                    result.append(BLZnumberFRC)
                    
                   }
                  catch{

                  }
                }
                catch{
                    
                }
            }
        } catch let error{
            print("Error \(error)")
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
                fullName: userDict["fullName"] as? String ?? "John Doe",
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
