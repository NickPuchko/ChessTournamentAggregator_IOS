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

    func addUserToDataBase() {
        var user: User
        let fullName = presenter.getFullName()
        let birthdate = presenter.getBirthdate()
        let eloRating = presenter.getEloRating()
        user = User(player: Player(fullName: fullName, birthdate: birthdate, rating: eloRating), phone: phoneNumber)
        //TODO
    }

    func getPhoneNumber() -> String {
        phoneNumber
    }
}
