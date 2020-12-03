//
// Created by Иван Лизогуб on 14.11.2020.
//

import Foundation


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
    }


}