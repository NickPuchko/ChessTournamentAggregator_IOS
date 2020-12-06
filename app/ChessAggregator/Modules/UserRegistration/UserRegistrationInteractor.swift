//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation
import Firebase

class UserRegistrationInteractor {
    weak var output: UserRegistrationInteractorOutput?
    private let phoneNumber: String

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

}

extension UserRegistrationInteractor: UserRegistrationInteractorInput {
    func addToDataBase(user: UserReg) {
        let firstNameWithSpace = " " + user.firstName!
        var patronymicNameWithSpace = ""
        if let patName = user.patronymicName, patName != "" {
            patronymicNameWithSpace = " " + patName
        } else {
            patronymicNameWithSpace = ""
        }
        let fullName = user.lastName! + firstNameWithSpace + patronymicNameWithSpace
        Auth.auth().createUser(withEmail: user.email!, password: user.password!) { (result, error) in
            if error == nil{
                if let result = result{
                    FirebaseRef.ref.child("Users").child(result.user.uid).updateChildValues(
                    ["fullname": fullName,"FideID": user.FideID!, "CFRID": user.CFRID!,
                     "email": user.email!, "password": user.password!,"isOrganizer": user.isOrganizer,
                     "organisationCity": user.organisationCity!, "organisationName": user.organisationName!]
                    )
                }
            }
        }
    }
}