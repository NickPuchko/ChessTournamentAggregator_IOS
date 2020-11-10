//
// Created by Иван Лизогуб on 05.11.2020.
//

import Foundation

class RegistrationInteractor: RegistrationInteractorProtocol {

    weak var presenter: RegistrationPresenterProtocol!
    private var phoneNumber: String

    required init(presenter: RegistrationPresenterProtocol, phoneNumber: String) {
        self.presenter = presenter
        self.phoneNumber = phoneNumber
    }

    func addUserToDataBase(lastName: String?, firstName: String?, patronymicName: String?,
                           ratingELO: String?, email: String?, password: String?, passwordValidation: String?,
                           organisationCity: String?, organisationName: String?, birthdate: Date) {
        //let fullName = buildFullName(lastName: lastName, firstName: firstName, patronymicName: patronymicName)
        //let eloRating = Int(ratingELO ?? "")
        //let user = User(player: Player(fullName: fullName, birthdate: birthdate, rating: eloRating), phone: phoneNumber)
        //TODO
    }


    func getPhoneNumber() -> String {
        phoneNumber
    }

    private func buildFullName(lastName: String?, firstName: String?, patronymicName: String?) -> String{
        var fullName: String = ""
        if let surname = lastName, let name = firstName {
            fullName = surname + " "
            fullName += name + " "
            fullName += patronymicName ?? ""
        } else {
            fatalError("They should not be nil")
        }

        return fullName
    }
}
