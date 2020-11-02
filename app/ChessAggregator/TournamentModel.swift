import Foundation

/*struct TableModel{
   // var response: String
   
    var response: String
    var access_token: String
    var refresh_token: String
 
    init(json: [String: Any]) {
        response = json["response"] as? String ?? ""
        access_token = json["access_token"] as? String ?? ""
        refresh_token = json["refresh_token"] as? String ?? ""
    }
}*/
struct Tournament{
    var name: String
    var mode: String
    
       init(json: [String: Any]) {
           name = json["name"] as? String ?? ""
           mode = json["mode"] as? String ?? ""
       }
}
