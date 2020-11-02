import Foundation
import SwiftKeychainWrapper
import CommonCrypto


func sha512( string: String) -> String {
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
    if let data = string.data(using: String.Encoding.utf8) {
        let value =  data as NSData
        CC_SHA512(value.bytes, CC_LONG(data.count), &digest)

    }
    var digestHex = ""
    for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
        digestHex += String(format: "%02x", digest[index])
    }

    return digestHex
}

func Post(url: String, request: String, login: String, hash: String) -> Void {

    let parameters = ["request" : request, "login": login, "hash": hash]

    //create the url with URL
    let url = URL(string: url)! //change the url

    //create the session object
    let session = URLSession.shared

    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST

    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
    } catch let error {
        print(error.localizedDescription)
    }

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

        guard error == nil else {
            return
        }

        guard let data = data else {
            return
        }

        do {
            //create json object from data
            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
            //parse
            
            let Tournament_ = Tournament(json: json)
           
            print (Tournament_.name)
            print (Tournament_.mode)

        } catch let error {
            print(error.localizedDescription)
        }
    })
    task.resume()
}
func getMethod(url: String) {
    guard let url = URL(string: url) else {
        print("Error: cannot create URL")
        return
    }
    // Create the url request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
    do {
        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            print("Error: Cannot convert data to JSON object")
            return
        }
        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
            print("Error: Cannot convert JSON object to Pretty JSON data")
            return
        }
        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
            print("Error: Could print JSON in String")
            return
        }
        print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
                }.resume()
}

